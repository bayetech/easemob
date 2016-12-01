require 'spec_helper'
require 'date'

RSpec.describe Easemob::Chatlog do
  describe '#chatmessages' do
    it 'get chat messages without any argument' do
      res = Easemob.chatmessages
      expect(res.code).to eq 200
      h1 = JSON.parse res.body.to_s
      expect(h1['entities'].count).to be >= 1
    end

    it 'get chat messages today only using after' do
      res = Easemob.chatmessages(after: Date.today.to_time)
      expect(res.code).to eq 200
      h1 = JSON.parse res.body.to_s
      expect(h1['entities'].count).to be >= 1
    end
  end
end
