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
      users = [{ username: 'u1', password: 'pwd' },
               { username: 'u2', password: 'pwd' },
               { username: 'u3', password: 'pwd' }]
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
      res = Easemob.get_user('Eric-Guo')
      expect(res.code).to eq 200
    end
  end

  context 'raise error' do
    specify 'raise UserNameError if given wrong username' do
      expect { Easemob.create_user('$$', '12345') }.to raise_error(Easemob::UserNameError)
    end
  end
end
