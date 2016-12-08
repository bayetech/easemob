require 'spec_helper'

RSpec.describe Easemob::Users do
  describe '#create_user' do
    it 'can create user with nickname' do
      res = Easemob.create_user('Eric-Guo_test', 'pwd', nickname: 'Eric')
      expect(res.code).to eq 200
    end
  end

  describe '#create_users' do
    it 'can create users in batch' do
      users = [{ username: 'ub1', password: 'pwd' },
               { username: 'ub2', password: 'pwd' },
               { username: 'ub3', password: 'pwd' }]
      res = Easemob.create_users(users)
      expect(res.code).to eq 200
    end

    it 'can create users with nickname' do
      users = [{ username: 'un1', password: 'pwd', nickname: 'n1' },
               { username: 'un2', password: 'pwd', nickname: 'n2' },
               { username: 'un3', password: 'pwd', nickname: 'n3' }]
      res = Easemob.create_users(users)
      expect(res.code).to eq 200
    end
  end

  describe '#get_user' do
    it 'can query user info' do
      res = Easemob.get_user('u')
      expect(res.code).to eq 200
    end
  end

  describe '#query_users' do
    it 'can query users in batch' do
      res = Easemob.query_users(3)
      expect(res.code).to eq 200
      h1 = JSON.parse res.body.to_s
      expect(h1['entities'][2]['username']).to eq 'u2'
    end

    it 'can query users in batch per page via cursor' do
      res1 = Easemob.query_users(3)
      expect(res1.code).to eq 200
      h1 = JSON.parse res1.body.to_s
      expect(h1['entities'][2]['username']).to eq 'u2'
      cursor = h1['cursor']
      res2 = Easemob.query_users(4, cursor: cursor)
      expect(res2.code).to eq 200
      h2 = JSON.parse res2.body.to_s
      expect(h2['entities'][3]['username']).to eq 'u6'
    end
  end

  describe '#delete_user' do
    it 'can delete user' do
      res = Easemob.delete_user('to_delete_user')
      expect(res.code).to eq 200
      h1 = JSON.parse res.body.to_s
      expect(h1['entities'][0]['username']).to eq 'to_delete_user'
    end
  end

  describe '#reset_user_password' do
    it 'can reset the user password' do
      res = Easemob.reset_user_password 'u', newpassword: 'new_pwd'
      expect(res.code).to eq 200
      h1 = JSON.parse res.body.to_s
      expect(h1['action']).to eq 'set user password'
    end
  end

  describe '#set_user_nickname' do
    it "set the user's nickname" do
      res = Easemob.set_user_nickname 'u', nickname: 'ONE'
      expect(res.code).to eq 200
      h1 = JSON.parse res.body.to_s
      expect(h1['entities'][0]['username']).to eq 'u'
      expect(h1['entities'][0]['nickname']).to eq 'ONE'
    end
  end

  describe '#add_user_friend' do
    it 'add u as friend of u1' do
      res = Easemob.add_user_friend 'u1', friend_username: 'u'
      expect(res.code).to eq 200
      h1 = JSON.parse res.body.to_s
      expect(h1['entities'][0]['username']).to eq 'u'
    end
  end

  describe '#remove_user_friend' do
    it 'remove u1 as friend of u' do
      res = Easemob.remove_user_friend 'u', friend_username: 'u1'
      expect(res.code).to eq 200
      h1 = JSON.parse res.body.to_s
      expect(h1['entities'][0]['username']).to eq 'u1'
    end
  end

  describe '#query_user_friends' do
    it "query user's friends" do
      res = Easemob.query_user_friends('u')
      expect(res.code).to eq 200
      h1 = JSON.parse res.body.to_s
      expect(h1['data'].count).to be >= 2
      expect(h1['data']).to include('u3')
    end
  end

  describe '#add_to_user_block' do
    it 'blocks a list of usernames for a user' do
      res = Easemob.add_to_user_block 'u1', to_block_usernames: %w(u2 u3)
      expect(res.code).to eq 200
      h1 = JSON.parse res.body.to_s
      expect(h1['data'].count).to be >= 2
      expect(h1['data']).to include('u3')
    end
  end

  describe '#remove_from_user_block' do
    it 'stop block a username for a user' do
      res = Easemob.remove_from_user_block 'u', blocked_username: 'u7'
      expect(res.code).to eq 200
      h1 = JSON.parse res.body.to_s
      expect(h1['entities'][0]['username']).to eq 'u7'
    end
  end

  describe '#query_user_blocks' do
    it "query user's blocks" do
      res = Easemob.query_user_blocks('u')
      expect(res.code).to eq 200
      h1 = JSON.parse res.body.to_s
      expect(h1['data'].count).to be >= 1
      expect(h1['data']).to include('u8')
    end
  end

  describe '#get_user_status' do
    it 'get user online status' do
      res = Easemob.get_user_status('u')
      expect(res.code).to eq 200
      h1 = JSON.parse res.body.to_s
      expect(h1['data']['u']).to_not be_nil
    end
  end

  describe '#get_user_offline_msg_count' do
    it 'get user total number of offline message' do
      res = Easemob.get_user_offline_msg_count('u')
      expect(res.code).to eq 200
      h1 = JSON.parse res.body.to_s
      expect(h1['data']['u']).to_not be_nil
    end
  end

  describe '#get_user_offline_msg_status' do
    it 'check user offline msg status' do
      res = Easemob.get_user_offline_msg_status('u', $easemob_rspec_greeting_msg_id)
      expect(res.code).to eq 200
      h1 = JSON.parse res.body.to_s
      expect(h1['data']).to_not be_nil
      expect(h1['data'][$easemob_rspec_greeting_msg_id]).to_not be_nil
    end
  end

  describe '#deactivate_user' do
    it 'Deactivate a user' do
      res = Easemob.deactivate_user('activated_user')
      expect(res.code).to eq 200
      h1 = JSON.parse res.body.to_s
      expect(h1['entities'][0]['username']).to eq 'activated_user'
      expect(h1['entities'][0]['activated']).to be false
    end
  end

  describe '#activate_user' do
    it 'Activate a user' do
      res = Easemob.activate_user('deactivated_user')
      expect(res.code).to eq 200
      h1 = JSON.parse res.body.to_s
      expect(h1['action']).to eq 'activate user'
    end
  end

  describe '#disconnect_user' do
    it 'Force to disconnect a user' do
      res = Easemob.disconnect_user('u9')
      expect(res.code).to eq 200
      h1 = JSON.parse res.body.to_s
      expect(h1['action']).to eq 'Disconnect user'
      expect(h1['data']['result']).not_to be nil
    end
  end

  context 'raise error' do
    specify 'raise UserNameError if given wrong username' do
      expect { Easemob.create_user('$$', '12345') }.to raise_error(Easemob::UserNameError)
    end
  end
end
