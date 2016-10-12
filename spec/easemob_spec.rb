require 'spec_helper'

describe Easemob do
  it 'can get token' do
    expect(Easemob.token).not_to be nil
  end
end
