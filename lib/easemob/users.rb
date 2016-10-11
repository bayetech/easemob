module Easemob
  module Users
    def create_user(username, password, nickname = nil)
      do_post('users', username: username, password: password, nickname: nickname)
    end
  end
end
