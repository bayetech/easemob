require 'http'
require 'json'
require 'easemob/version'
require 'easemob/token'

module Easemob
  class << self
    attr_accessor :client_id     # 使用 APP 的 client_id
    attr_accessor :client_secret # 和 client_secret 获取授权管理员 token

    attr_writer :base_url
    attr_writer :org_name        # 企业的唯一标识，开发者管理后台注册账号时填写的企业 ID
    attr_writer :app_name        # 同一“企业”下“APP”唯一标识，在环信开发者管理后台创建应用时填写的“应用名称”

    attr_accessor :token_file_path
  end
  @base_url = 'https://a1.easemob.com'
  @token_file_path = '/tmp/easemob_token'
  @random_generator = Random.new

  def self.head_url
    "#{@base_url}/#{@org_name}/#{@app_name}"
  end

  def self.httprb
    @httprb ||= HTTP.persistent @base_url
  end

  def self.do_post(resource, body_hash)
    httprb.post "#{head_url}/#{resource}", json: body_hash
  end

  def self.token
    # Possible two worker running, one worker refresh token, other unaware, so must read every time
    access_token, remain_life_seconds = Token.read_from_store
    Token.refresh if remain_life_seconds < @random_generator.rand(30..3 * 60)
    access_token
  end
end
