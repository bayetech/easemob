require 'http'
require 'json'
require 'connection_pool'
require 'easemob/version'
require 'easemob/token'
require 'easemob/users'
require 'easemob/groups'

module Easemob
  class UserNameError < RuntimeError; end
  class QuotaLimitError < RuntimeError; end

  class << self
    attr_accessor :client_id     # 使用 APP 的 client_id
    attr_accessor :client_secret # 和 client_secret 获取授权管理员 token

    attr_writer :base_url
    attr_writer :org_name        # 企业的唯一标识，开发者管理后台注册账号时填写的企业 ID
    attr_writer :app_name        # 同一“企业”下“APP”唯一标识，在环信开发者管理后台创建应用时填写的“应用名称”

    attr_writer :token_file_path
    attr_writer :http_pool
    attr_writer :http_timeout
  end
  @base_url = 'https://a1.easemob.com'
  @random_generator = Random.new
  @http_pool = 5
  @http_timeout = 5
  @token_file_path = nil

  # Make an HTTP request with the given verb to easemob server
  # @param verb [Symbol]
  # @param resource [String]
  # @option options [Hash]
  # @return [HTTP::Response]
  def self.request(verb, resource, options = {})
    httprbs.with do |http|
      res = do_request(verb, http, resource, options)
      case res.code
      # 401:（未授权）请求要求身份验证。对于需要 token 的接口，服务器可能返回此响应。
      when 401
        Token.refresh
        res = do_request(verb, http, resource, options)
      # 408:（请求超时）服务器等候请求时发生超时。
      when 408
        res = do_request(verb, http, resource, options)
      # 503:（服务不可用）请求接口超过调用频率限制，即接口被限流。
      when 429, 503
        sleep 1
        res = do_request(verb, http, resource, options)
        raise QuotaLimitError, 'Return http status code is 429/503, hit quota limit of Easemob service,' if [429, 503].include?(res.code)
      end
      res
    end
  end

  # Get admin access token from easemob server
  # @return access_token [String]
  def self.token
    # Possible two worker running, one worker refresh token, other unaware, so must read every time
    access_token, remain_life_seconds = Token.read_from_store
    Token.refresh if remain_life_seconds < @random_generator.rand(30..3 * 60)
    access_token
  end

  class << self
    include Users
    include Groups
  end

  private_class_method

  def self.do_request(verb, http, resource, options)
    http.headers('Authorization' => "Bearer #{token}")
        .request(verb, "#{head_url}/#{resource}", options)
  end

  def self.httprbs
    @httprbs ||= ConnectionPool.new(size: @http_pool, timeout: @http_timeout) { HTTP.persistent @base_url }
  end

  def self.head_url
    "#{@base_url}/#{@org_name}/#{@app_name}"
  end

  def self.token_file_path
    @token_file_path || "/tmp/easemob_#{@org_name}_#{@app_name}_token"
  end
end
