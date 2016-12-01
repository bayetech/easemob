module Easemob
  autoload(:UserMessage, File.expand_path('message/user_message', __dir__))
  module Users
    def create_user(username, password, nickname: nil)
      valid_username!(username)
      jd = { username: username, password: password }
      jd[:nickname] = nickname unless nickname.nil?
      UserMessage.new request :post, 'users', json: jd
    end

    def create_users(users)
      users.map { |user| valid_username!(user['username'] || user[:username]) }
      UserMessage.new request :post, 'users', json: users
    end

    def get_user(username)
      UserMessage.new request :get, "users/#{username}"
    end

    def query_users(limit = 50, cursor: nil)
      params = { limit: limit }
      params[:cursor] = cursor unless cursor.nil?
      UserMessage.new request :get, 'users', params: params
    end

    def delete_user(username)
      UserMessage.new request :delete, "users/#{username}"
    end

    def delete_users!(number = 100)
      UserMessage.new request :delete, 'users', params: { limit: number }
    end

    def reset_user_password(username, newpassword:)
      UserMessage.new request :put, "users/#{username}/password", json: { newpassword: newpassword }
    end

    def set_user_nickname(username, nickname:)
      UserMessage.new request :put, "users/#{username}", json: { nickname: nickname }
    end

    def add_user_friend(owner_username, friend_username:)
      UserMessage.new request :post, "users/#{owner_username}/contacts/users/#{friend_username}"
    end

    def remove_user_friend(owner_username, friend_username:)
      UserMessage.new request :delete, "users/#{owner_username}/contacts/users/#{friend_username}"
    end

    def query_user_friends(owner_username)
      UserMessage.new request :get, "users/#{owner_username}/contacts/users"
    end

    def add_to_user_block(owner_username, to_block_usernames:)
      UserMessage.new request :post, "users/#{owner_username}/blocks/users", json: { usernames: [*to_block_usernames] }
    end

    def remove_from_user_block(owner_username, blocked_username:)
      UserMessage.new request :delete, "users/#{owner_username}/blocks/users/#{blocked_username}"
    end

    def query_user_blocks(owner_username)
      UserMessage.new request :get, "users/#{owner_username}/blocks/users"
    end

    def get_user_status(username)
      UserMessage.new request :get, "users/#{username}/status"
    end

    def get_user_offline_msg_count(owner_username)
      UserMessage.new request :get, "users/#{owner_username}/offline_msg_count"
    end

    def get_user_offline_msg_status(username, msg_id)
      UserMessage.new request :get, "users/#{username}/offline_msg_status/#{msg_id}"
    end

    def deactivate_user(username)
      UserMessage.new request :post, "users/#{username}/deactivate"
    end

    def activate_user(username)
      UserMessage.new request :post, "users/#{username}/activate"
    end

    def disconnect_user(username)
      UserMessage.new request :get, "users/#{username}/disconnect"
    end

    private

    def valid_username!(username)
      raise UserNameError, "#{username} is invalid for easemob" unless username[/[a-zA-Z0-9_-]*/] == username
    end
  end
end
