require 'spec_helper'
require 'date'

RSpec.describe Easemob::Chatlog do
  describe '#chatmessages' do
    it 'get chat messages without any argument' do
      res = Easemob.chatmessages
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['count']).not_to be nil
    end

    it 'get chat messages today only using after' do
      res = Easemob.chatmessages(after: Date.today.to_time)
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['count']).not_to be nil
    end
  end
end
