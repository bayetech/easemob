module Easemob
  module Fileoperation
    def upload_chatfile(file_path, restrict_access: true)
      request :upload, 'chatfiles', form: { file: HTTP::FormData::File.new(file_path),
                                            hack: 'X' }, # Existing here for http-form_data 1.0.1 handle single param improperly, see https://github.com/httprb/form_data.rb/issues/4
                                    restrict_access: restrict_access
    end

    def download_chatfile(chatfile_uuid, share_secret: nil, thumbnail: false)
      request :download, "chatfiles/#{chatfile_uuid}", share_secret: share_secret, thumbnail: thumbnail
    end
  end
end
