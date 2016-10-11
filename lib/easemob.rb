require 'http'
require 'json'
require 'connection_pool'
require 'easemob/version'
require 'easemob/token'
require 'easemob/users'

module Easemob
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

  def self.head_url
    "#{@base_url}/#{@org_name}/#{@app_name}"
  end

  def self.token_file_path
    @token_file_path || "/tmp/easemob_#{@org_name}_#{@app_name}_token"
  end

  def self.httprbs
    @httprbs ||= ConnectionPool.new(size: @http_pool, timeout: @http_timeout) { HTTP.persistent @base_url }
  end

  def self.do_post(resource, body_hash)
    httprbs.with do |http|
      http.headers('Authorization' => "Bearer #{token}")
          .post "#{head_url}/#{resource}", json: body_hash
    end
  end

  def self.token
    # Possible two worker running, one worker refresh token, other unaware, so must read every time
    access_token, remain_life_seconds = Token.read_from_store
    Token.refresh if remain_life_seconds < @random_generator.rand(30..3 * 60)
    access_token
  end

  class << self
    include Users
  end
end
