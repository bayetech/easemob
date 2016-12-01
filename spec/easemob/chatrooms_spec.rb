require 'spec_helper'

RSpec.describe Easemob::Chatrooms do
  describe '#create_chatroom' do
    it 'can create chatroom without any member' do
      res = Easemob.create_chatroom('c1', 'chatroom 1', 'u1')
      expect(res.code).to eq 200
      h1 = JSON.parse res.body.to_s
      expect(h1['data']['id']).not_to be nil
    end

    it 'can create chatroom with members' do
      res = Easemob.create_chatroom 'c2', 'chatroom 2', 'u1', members: %w(u2 u3)
      expect(res.code).to eq 200
      h1 = JSON.parse res.body.to_s
      expect(h1['data']['id']).not_to be nil
    end
  end

  describe '#get_chatroom' do
    it 'get chatroom info by given chatroom_id' do
      res = Easemob.get_chatroom($easemob_rspec_chatroom_c_id)
      expect(res.code).to eq 200
      h1 = JSON.parse res.body.to_s
      expect(h1['data'][0]['id']).to eq $easemob_rspec_chatroom_c_id
      expect(h1['data'][0]['public']).to be true
      expect(h1['data'][0]['allowinvites']).to be false
      expect(h1['data'][0]['affiliations_count']).to be >= 2
    end
  end

  describe '#query_chatrooms' do
    it 'get all chatrooms' do
      res = Easemob.query_chatrooms
      expect(res.code).to eq 200
      h1 = JSON.parse res.body.to_s
      expect(h1['data'].count).to be >= 1
    end
  end

  describe '#user_joined_chatrooms' do
    it 'Get a user joined chatrooms list' do
      res = Easemob.user_joined_chatrooms('u')
      expect(res.code).to eq 200
      h1 = JSON.parse res.body.to_s
      expect(h1['data'].count).to be >= 1
    end
  end

  describe '#delete_chatroom' do
    it 'can delete chatroom' do
      res = Easemob.delete_chatroom $easemob_rspec_to_delete_chatroom_id
      expect(res.code).to eq 200
      h1 = JSON.parse res.body.to_s
      expect(h1['data']['success']).to be true
      expect(h1['data']['id']).to eq $easemob_rspec_to_delete_chatroom_id
    end
  end

  describe '#modify_chatroom' do
    it 'can modify chatroom with new name and description' do
      res = Easemob.modify_chatroom($easemob_rspec_chatroom_c_id, chatroom_name: 'c', description: 'chatroom after modified')
      expect(res.code).to eq 200
      h1 = JSON.parse res.body.to_s
      expect(h1['data']['name']).to be true
      expect(h1['data']['description']).to be true
      expect(h1['data']['maxusers']).to be nil
    end

    it 'can set maxusers to 500' do
      res = Easemob.modify_chatroom($easemob_rspec_chatroom_c_id, maxusers: 500)
      expect(res.code).to eq 200
      h1 = JSON.parse res.body.to_s
      expect(h1['data']['name']).to be nil
      expect(h1['data']['description']).to be nil
      expect(h1['data']['maxusers']).to be true
    end
  end

  describe '#user_join_chatroom' do
    it 'A chatroom can add one user' do
      res = Easemob.user_join_chatroom($easemob_rspec_chatroom_c_id, username: 'u6')
      expect(res.code).to eq 200
      h1 = JSON.parse res.body.to_s
      expect(h1['data']['action']).to eq 'add_member'
      expect(h1['data']['result']).to be true
      expect(h1['data']['id']).to eq $easemob_rspec_chatroom_c_id
      expect(h1['data']['user']).to eq 'u6'
    end
  end

  describe '#user_leave_chatroom' do
    it 'A chatroom can remove one user' do
      res = Easemob.user_leave_chatroom($easemob_rspec_chatroom_c_id, username: 'u3')
      expect(res.code).to eq 200
      h1 = JSON.parse res.body.to_s
      expect(h1['data']['action']).to eq 'remove_member'
      expect(h1['data']['result']).to be true
      expect(h1['data']['id']).to eq $easemob_rspec_chatroom_c_id
      expect(h1['data']['user']).to eq 'u3'
    end
  end

  describe '#chatroom_add_users' do
    it 'Can add multi users to a chatroom' do
      res = Easemob.chatroom_add_users($easemob_rspec_chatroom_c_id, usernames: %w(u7 u8))
      expect(res.code).to eq 200
      h1 = JSON.parse res.body.to_s
      expect(h1['data']['action']).to eq 'add_member'
      expect(h1['data']['id']).to eq $easemob_rspec_chatroom_c_id
      expect(h1['data']['newmembers']).to match_array %w(u7 u8)
    end
  end

  describe '#chatroom_remove_users' do
    it 'Can remove multi users from a chatroom' do
      res = Easemob.chatroom_remove_users($easemob_rspec_chatroom_c_id, usernames: %w(u1 u2))
      expect(res.code).to eq 200
      h1 = JSON.parse res.body.to_s
      expect(h1['data'].count).to eq 2
    end
  end
end
