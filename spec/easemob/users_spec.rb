require 'spec_helper'

RSpec.describe Easemob::Users do
  it 'can create_user' do
    res = Easemob.create_user('e', '12345', 'e')
    expect(res.code).to eq 200
  end

  context 'raise error' do
    specify 'raise UserNameError if given wrong username' do
      expect { Easemob.create_user('$$', '12345') }.to raise_error(Easemob::UserNameError)
    end
  end
end
