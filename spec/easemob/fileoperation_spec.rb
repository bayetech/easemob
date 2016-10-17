require 'spec_helper'

RSpec.describe Easemob::Fileoperation do
  describe '#upload_chatfiles' do
    it 'can upload a picture file' do
      res = Easemob.upload_chatfiles('spec/easemob_logo.png')
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['entities']).not_to be nil
      expect(h1['entities'][0]['type']).to eq 'chatfile'
      expect(h1['entities'][0]['share-secret']).not_to be nil
    end
  end
end
