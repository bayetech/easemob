module Easemob
  module Messages
    def message_to(target, target_type: :users, msg:,
                   from: nil, ext: nil)
    end

    def image_to(target, target_type: :users, url:, filename:,
                 secret: nil, from: nil, image_size: nil, ext: nil)
    end

    def audio_to(target, target_type: :users, url:, filename:, length:,
                 secret: nil, from: nil, ext: nil)
    end

    def video_to(target, target_type: :users, url:, filename:, file_length:, thumb:,
                 secret: nil, thumb_secret: nil, from: nil, ext: nil)
    end

    def command_to(target, target_type: :users, action:,
                   from: nil, ext: nil)
    end
  end
end
