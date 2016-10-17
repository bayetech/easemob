require 'spec_helper'

RSpec.describe Easemob::Messages do
  describe '#message_to' do
    it 'can sent message to user' do
      res = Easemob.message_to 'u1', text: "hello, world\n"
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['data']).not_to be nil
      expect(h1['data']['u1']).to eq 'success'
    end
  end
end
