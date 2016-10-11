module Easemob
  module Token
    def self.refresh
      res = Easemob.httprbs.with do |http|
        http.post "#{Easemob.head_url}/token", json: { grant_type: 'client_credentials', client_id: Easemob.client_id, client_secret: Easemob.client_secret }
      end
      raise "Failed to refresh easemob token: #{res}" unless res.code == 200
      write_to_store(JSON.parse(res.to_s))
      read_from_store
    end

    def self.read_from_store
      td = read_token
      token_life_in_seconds = td.fetch('token_expires_in').to_i
      got_token_at = td.fetch('got_token_at').to_i
      access_token = td.fetch('access_token')
      remain_life_seconds = token_life_in_seconds - (Time.now.to_i - got_token_at)
      return [access_token, remain_life_seconds]
    rescue JSON::ParserError, Errno::ENOENT, KeyError, TypeError
      refresh
    end

    def self.write_to_store(token_hash)
      token_hash['got_token_at'.freeze] = Time.now.to_i
      token_hash['token_expires_in'.freeze] = token_hash.delete('expires_in')
      write_token(token_hash)
    end

    def self.read_token
      JSON.parse(File.read(Easemob.token_file_path))
    end

    def self.write_token(token_hash)
      File.write(Easemob.token_file_path, token_hash.to_json)
    end
  end
end
