require 'spec_helper'

RSpec.describe Easemob::Users do
  describe '#create_user' do
    it 'can create user with nickname' do
      res = Easemob.create_user('Eric-Guo', 'pwd', 'Eric')
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
      h1 = JSON.parse res.to_s
      expect(h1['entities'][2]['username']).to eq 'u2'
    end

    it 'can query users in batch per page via cursor' do
      res1 = Easemob.query_users(3)
      expect(res1.code).to eq 200
      h1 = JSON.parse res1.to_s
      expect(h1['entities'][2]['username']).to eq 'u2'
      cursor = h1['cursor']
      res2 = Easemob.query_users(4, cursor)
      expect(res2.code).to eq 200
      h2 = JSON.parse res2.to_s
      expect(h2['entities'][3]['username']).to eq 'u6'
    end
  end

  describe '#delete_user' do
    it 'can delete user' do
      res = Easemob.delete_user('u9')
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['entities'][0]['username']).to eq 'u9'
    end
  end

  describe '#reset_user_password' do
    it 'can reset the user password' do
      res = Easemob.reset_user_password('u', 'new_pwd')
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['action']).to eq 'set user password'
    end
  end

  describe '#set_user_nickname' do
    it "set the user's nickname" do
      res = Easemob.set_user_nickname('u', 'ONE')
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['entities'][0]['username']).to eq 'u'
      expect(h1['entities'][0]['nickname']).to eq 'ONE'
    end
  end

  describe '#add_user_friend' do
    it 'add u as friend of u1' do
      res = Easemob.add_user_friend('u1', 'u')
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['entities'][0]['username']).to eq 'u'
    end
  end

  describe '#remove_user_friend' do
    it 'remove u1 as friend of u' do
      res = Easemob.remove_user_friend('u', 'u1')
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['entities'][0]['username']).to eq 'u1'
    end
  end

  describe '#query_user_friends' do
    it "query user's friends" do
      res = Easemob.query_user_friends('u')
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['data'].count).to be >= 2
      expect(h1['data']).to include('u3')
    end
  end

  describe '#add_user_blocks' do
    it 'blocks a list of usernames for a user' do
      res = Easemob.add_user_blocks 'u1', %w(u2 u3)
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['data'].count).to be >= 2
      expect(h1['data']).to include('u3')
    end
  end

  describe '#remove_user_block' do
    it 'stop block a username for a user' do
      res = Easemob.remove_user_block 'u', 'u7'
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['entities'][0]['username']).to eq 'u7'
    end
  end

  describe '#query_user_blocks' do
    it "query user's blocks" do
      res = Easemob.query_user_blocks('u')
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['data'].count).to be >= 1
      expect(h1['data']).to include('u8')
    end
  end

  context 'raise error' do
    specify 'raise UserNameError if given wrong username' do
      expect { Easemob.create_user('$$', '12345') }.to raise_error(Easemob::UserNameError)
    end
  end
end
