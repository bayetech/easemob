require 'spec_helper'

RSpec.describe Easemob::Users do
  it 'can create_user' do
    res = Easemob.create_user('Eric-Guo', 'pwd', 'Eric')
    expect(res.code).to eq 200
  end

  it 'can create_users' do
    users = [{ username: 'u1', password: 'pwd' },
             { username: 'u2', password: 'pwd' },
             { username: 'u3', password: 'pwd' }]
    res = Easemob.create_users(users)
    expect(res.code).to eq 200
  end

  context 'raise error' do
    specify 'raise UserNameError if given wrong username' do
      expect { Easemob.create_user('$$', '12345') }.to raise_error(Easemob::UserNameError)
    end
  end
end
