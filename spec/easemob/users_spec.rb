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
      h = JSON.parse res.to_s
      expect(h['entities'][2]['username']).to eq 'u2'
    end
  end

  context 'raise error' do
    specify 'raise UserNameError if given wrong username' do
      expect { Easemob.create_user('$$', '12345') }.to raise_error(Easemob::UserNameError)
    end
  end
end
