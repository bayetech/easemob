module Easemob
  module Chatrooms
    def create_chatroom(chatroom_name, description, owner, maxusers: 200, members: nil)
      jd = { name: chatroom_name, description: description, owner: owner, maxusers: maxusers }
      jd[:members] = members unless members.nil?
      request :post, 'chatrooms', json: jd
    end
  end
end
