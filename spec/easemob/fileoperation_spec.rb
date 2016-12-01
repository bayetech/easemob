require 'spec_helper'
require 'fileutils'

RSpec.describe Easemob::Fileoperation do
  describe '#upload_chatfile' do
    it 'can upload a picture file' do
      res = Easemob.upload_chatfile('spec/easemob_logo.png')
      expect(res.code).to eq 200
      h1 = JSON.parse res.body.to_s
      expect(h1['entities']).not_to be nil
      expect(h1['entities'][0]['uuid']).not_to be nil
      expect(h1['entities'][0]['type']).to eq 'chatfile'
      expect(h1['entities'][0]['share-secret']).not_to be nil
    end
  end

  describe '#download_chatfile' do
    it 'can download a picture file' do
      res = Easemob.download_chatfile($easemob_rspec_easemob_logo_uuid, share_secret: $easemob_rspec_easemob_logo_share_secret)
      expect(res.code).to eq 200
      to_write_file_path = 'spec/easemob_logo_download.png'
      File.write(to_write_file_path, res.body)
      expect(FileUtils.compare_file('spec/easemob_logo.png', to_write_file_path)).to be_truthy
    end

    it 'can download a picture file in thumbnail' do
      res = Easemob.download_chatfile($easemob_rspec_easemob_logo_uuid, share_secret: $easemob_rspec_easemob_logo_share_secret,
                                                                        thumbnail: true)
      expect(res.code).to eq 200
      to_write_file_path = 'spec/easemob_logo_thumbnail.png'
      File.write(to_write_file_path, res.body)
      expect(FileUtils.compare_file('spec/easemob_logo.png', to_write_file_path)).to be false
    end
  end
end
