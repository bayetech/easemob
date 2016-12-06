require 'spec_helper'

RSpec.describe Easemob::Messages do
  describe '#message_to' do
    it 'can sent text message to user' do
      res = Easemob.message_to 'u1', text: "hello, world\n"
      expect(res.code).to eq 200
      h1 = JSON.parse res.body.to_s
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
      h1 = JSON.parse res.body.to_s
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

      return_result = OpenStruct.new(headers: {'Content-Type' => 'application/json'} , code: 200, body: { 'data' => { 'testb' => 'success', 'testc' => 'success', 'testd' => 'success' } }.to_json)

      expect(Easemob).to receive(:request)
        .with(:post, 'messages', json: request_payload)
        .and_return(return_result)

      # Too hard to mock HTTP::Response, so using hash instead.
      h1 = Easemob.audio_to to_users, url: Easemob.chatfile_url('1dfc7f50-55c6-11e4-8a07-7d75b8fb3d42'),
                                      filename: 'messages.amr', length: 10,
                                      secret: 'Hfx_WlXGEeSdDW-SuX2EaZcXDC7ZEig3OgKZye9IzKOwoCjM',
                                      from: 'testa'
      expect(h1.data).not_to be nil
      expect(h1.data['testb']).to eq 'success'
      expect(h1.data['testc']).to eq 'success'
      expect(h1.data['testd']).to eq 'success'
    end
  end

  describe '#video_to' do
    it 'can sent video message to user' do
      to_users = %w(testb testc testd)

      request_payload = {
        target_type: :users,
        target: to_users,
        msg: { type: :video, url: Easemob.chatfile_url('671dfe30-7f69-11e4-ba67-8fef0d502f46'),
               filename: '1418105136313.mp4', length: 0, file_length: 58103,
               thumb: Easemob.chatfile_url('671dfe30-7f69-11e4-ba67-8fef0d502f46'),
               secret: 'VfEpSmSvEeS7yU8dwa9rAQc-DIL2HhmpujTNfSTsrDt6eNb_',
               thumb_secret: 'ZyebKn9pEeSSfY03ROk7ND24zUf74s7HpPN1oMV-1JxN2O2I' },
        from: 'testa'
      }

      return_result = OpenStruct.new(headers: {'Content-Type' => 'application/json'} , code: 200, body: { 'data' => { 'testb' => 'success', 'testc' => 'success', 'testd' => 'success' } }.to_json)

      expect(Easemob).to receive(:request)
        .with(:post, 'messages', json: request_payload)
        .and_return(return_result)

      # Too hard to mock HTTP::Response, so using hash instead.
      h1 = Easemob.video_to to_users, url: Easemob.chatfile_url('671dfe30-7f69-11e4-ba67-8fef0d502f46'),
                                      filename: '1418105136313.mp4', length: 0, file_length: 58103,
                                      thumb: Easemob.chatfile_url('671dfe30-7f69-11e4-ba67-8fef0d502f46'),
                                      secret: 'VfEpSmSvEeS7yU8dwa9rAQc-DIL2HhmpujTNfSTsrDt6eNb_',
                                      thumb_secret: 'ZyebKn9pEeSSfY03ROk7ND24zUf74s7HpPN1oMV-1JxN2O2I',
                                      from: 'testa'
      expect(h1.data).not_to be nil
      expect(h1.data['testb']).to eq 'success'
      expect(h1.data['testc']).to eq 'success'
      expect(h1.data['testd']).to eq 'success'
    end
  end

  describe '#command_to' do
    it 'can sent command message to user' do
      res = Easemob.command_to 'g', target_type: :chatgroups, action: 'baye_joined'
      expect(res.code).to eq 200
      expect(res.data).not_to be nil
      expect(res.to_s).to eq res.body.to_s
      expect(res.inspect).not_to be nil
      expect(res.data['g']).to eq 'success'
      expect(res.all_success?).to eq true
    end
  end
end
