require 'spec_helper'

RSpec.describe Easemob do
  it 'can get token' do
    expect(Easemob.token).not_to be nil
  end
end
