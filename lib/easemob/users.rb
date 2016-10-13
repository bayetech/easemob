module Easemob
  module Users
    def create_user(username, password, nickname = nil)
      valid_username!(username)
      request(:post, 'users', json: { username: username, password: password, nickname: nickname })
    end

    def create_users(users)
      users.map { |user| valid_username!(user['username'] || user[:username]) }
      request(:post, 'users', json: users)
    end

    def get_user(username)
      request(:get, "users/#{username}")
    end

    private

    def valid_username!(username)
      raise UserNameError, "#{username} is invalid for easemob" unless username[/[a-zA-Z0-9_-]*/] == username
    end
  end
end
