module Easemob
  module Users
    def create_user(username, password, nickname = nil)
      valid_username!(username)
      request :post, 'users', json: { username: username, password: password, nickname: nickname }
    end

    def create_users(users)
      users.map { |user| valid_username!(user['username'] || user[:username]) }
      request :post, 'users', json: users
    end

    def get_user(username)
      request :get, "users/#{username}"
    end

    def query_users(limit, cursor = nil)
      params = { limit: limit }
      params[:cursor] = cursor unless cursor.nil?
      request :get, 'user', params: params
    end

    def delete_user(username)
      request :delete, "users/#{username}"
    end

    def delete_users!(number = 100)
      request :delete, 'users', params: { limit: number }
    end

    def reset_user_password(username, newpassword)
      request :put, "users/#{username}/password", json: { newpassword: newpassword }
    end

    def set_user_nickname(username, nickname)
      request :put, "users/#{username}", json: { nickname: nickname }
    end

    def add_user_friend(owner_username, friend_username)
      request :post, "users/#{owner_username}/contacts/users/#{friend_username}"
    end

    def remove_user_friend(owner_username, friend_username)
      request :delete, "users/#{owner_username}/contacts/users/#{friend_username}"
    end

    def query_user_friends(owner_username)
      request :get, "users/#{owner_username}/contacts/users"
    end

    def add_user_blocks(owner_username, usernames)
      request :post, "users/#{owner_username}/blocks/users", json: { usernames: usernames }
    end

    def remove_user_block(owner_username, blocked_username)
      request :delete, "users/#{owner_username}/blocks/users/#{blocked_username}"
    end

    def query_user_blocks(owner_username)
      request :get, "users/#{owner_username}/blocks/users"
    end

    private

    def valid_username!(username)
      raise UserNameError, "#{username} is invalid for easemob" unless username[/[a-zA-Z0-9_-]*/] == username
    end
  end
end
