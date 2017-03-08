module Easemob
  autoload(:FileoperationMessage, File.expand_path('message/fileoperation_message', __dir__))
  module Fileoperation
    def upload_chatfile(file_path, restrict_access: true)
      FileoperationMessage.new request :upload, 'chatfiles', form: { file: HTTP::FormData::File.new(file_path),
                                                                     hack: 'X' }, # Existing here for http-form_data 1.0.1 handle single param improperly, see https://github.com/httprb/form_data.rb/issues/4
                                                             restrict_access: restrict_access
    end

    def download_chatfile(chatfile_uuid, share_secret: nil, thumbnail: false)
      FileoperationMessage.new request :download, "chatfiles/#{chatfile_uuid}", share_secret: share_secret, thumbnail: thumbnail
    end
  end
end
