require 'spec_helper'

RSpec.describe Easemob::Messages do
  describe '#message_to' do
    it 'can sent text message to user' do
      res = Easemob.message_to 'u1', text: "hello, world\n"
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['data']).not_to be nil
      expect(h1['data']['u1']).to eq 'success'
    end
  end

  describe '#image_to' do
    it 'can sent image message to user' do
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

  describe '#audio_to' do
    it 'can sent audio message to user' do
      to_users = %w(testb testc testd)

      request_payload = {
        target_type: :users,
        target: to_users,
        msg: { type: :audio, url: Easemob.chatfile_url('1dfc7f50-55c6-11e4-8a07-7d75b8fb3d42'),
               filename: 'messages.amr', length: 10,
               secret: 'Hfx_WlXGEeSdDW-SuX2EaZcXDC7ZEig3OgKZye9IzKOwoCjM' },
        from: 'testa'
      }

      return_result = { 'data' => { 'testb' => 'success', 'testc' => 'success', 'testd' => 'success' } }

      expect(Easemob).to receive(:request)
        .with(:post, 'messages', json: request_payload)
        .and_return(return_result)

      # Too hard to mock HTTP::Response, so using hash instead.
      h1 = Easemob.audio_to to_users, url: Easemob.chatfile_url('1dfc7f50-55c6-11e4-8a07-7d75b8fb3d42'),
                                      filename: 'messages.amr', length: 10,
                                      secret: 'Hfx_WlXGEeSdDW-SuX2EaZcXDC7ZEig3OgKZye9IzKOwoCjM',
                                      from: 'testa'
      expect(h1['data']).not_to be nil
      expect(h1['data']['testb']).to eq 'success'
      expect(h1['data']['testc']).to eq 'success'
      expect(h1['data']['testd']).to eq 'success'
    end
  end

  describe '#command_to' do
    it 'can sent command message to user' do
      res = Easemob.command_to 'g', target_type: :chatgroups, action: 'baye_joined'
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['data']).not_to be nil
      expect(h1['data']['g']).to eq 'success'
    end
  end
end
