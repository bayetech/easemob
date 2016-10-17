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

  describe '#image_to' do
    it 'can sent message to user' do
      res = Easemob.image_to %w(u2 u3), url: Easemob.chatfile_url($easemob_rspec_easemob_logo_uuid),
                                        filename: 'easemob_logo.png',
                                        secret: $easemob_rspec_easemob_logo_share_secret,
                                        from: 'u1', image_size: { width: 210, height: 71 }
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['data']).not_to be nil
      expect(h1['data']['u2']).to eq 'success'
      expect(h1['data']['u3']).to eq 'success'
    end
  end

  describe '#command_to' do
    it 'can sent message to user' do
      res = Easemob.command_to 'g', target_type: :chatgroups, action: 'baye_joined'
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['data']).not_to be nil
      expect(h1['data']['g']).to eq 'success'
    end
  end
end
