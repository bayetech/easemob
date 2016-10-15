module Easemob
  module Chatrooms
    def create_chatroom(chatroom_name, description, owner, maxusers: 200, members: nil)
      jd = { name: chatroom_name, description: description, owner: owner, maxusers: maxusers }
      jd[:members] = members unless members.nil?
      request :post, 'chatrooms', json: jd
    end

    def modify_chatroom(chatroom_id, chatroom_name: nil, description: nil, maxusers: nil)
      jd = {}
      jd[:name] = chatroom_name unless chatroom_name.nil?
      jd[:description] = description unless description.nil?
      jd[:maxusers] = maxusers unless maxusers.nil?
      request :put, "chatrooms/#{chatroom_id}", json: jd
    end
  end
end
