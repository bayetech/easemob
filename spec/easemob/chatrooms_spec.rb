require 'spec_helper'

RSpec.describe Easemob::Chatrooms do
  describe '#create_chatroom' do
    it 'can create chat room without any member' do
      res = Easemob.create_chatroom('c1', 'chat room 1', 'u1')
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['data']['id']).not_to be nil
    end

    it 'can create chat room with members' do
      res = Easemob.create_chatroom 'c2', 'chat room 2', 'u1', members: %w(u2 u3)
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['data']['id']).not_to be nil
    end
  end
end
