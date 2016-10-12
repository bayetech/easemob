require 'spec_helper'

describe Easemob::Users do
  it 'can create_user' do
    res = Easemob.create_user('e', '12345', 'e')
    expect(res.code).to eq 200
  end
end
