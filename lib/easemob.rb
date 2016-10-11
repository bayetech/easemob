require 'easemob/version'

module Easemob
  class << self
    attr_accessor :client_id     # 使用 APP 的 client_id
    attr_accessor :client_secret # 和 client_secret 获取授权管理员 token

    attr_writer :base_url
    attr_writer :org_name        # 企业的唯一标识，开发者管理后台注册账号时填写的企业 ID
    attr_writer :app_name        # 同一“企业”下“APP”唯一标识，在环信开发者管理后台创建应用时填写的“应用名称”
  end
  @base_url = 'https://a1.easemob.com'

  def self.head_url
    "#{@base_url}/#{@org_name}/#{@app_name}"
  end
end
