module Easemob
  module Messages
    def message_to(target, target_type: :users, text:,
                   from: nil, ext: nil)
      jd = { target_type: target_type, target: [*target],
             msg: { type: :txt, txt: text } }
      jd[:from] = from unless from.nil?
      jd[:ext] = ext unless ext.nil?
      request :post, 'messages', json: jd
    end

    def image_to(target, target_type: :users, url:, filename:,
                 secret: nil, from: nil, image_size: nil, ext: nil)
      jd = { target_type: target_type, target: [*target],
             msg: { type: :img, filename: filename, url: url } }
      jd[:msg][:secret] = secret unless secret.nil?
      jd[:from] = from unless from.nil?
      jd[:size] = image_size unless image_size.nil?
      jd[:ext] = ext unless ext.nil?
      request :post, 'messages', json: jd
    end

    def audio_to(target, target_type: :users, url:, filename:, length:,
                 secret: nil, from: nil, ext: nil)
      jd = { target_type: target_type, target: [*target],
             msg: { type: :audio, filename: filename, url: url, length: length } }
      jd[:msg][:secret] = secret unless secret.nil?
      jd[:from] = from unless from.nil?
      jd[:ext] = ext unless ext.nil?
      request :post, 'messages', json: jd
    end

    def video_to(target, target_type: :users, url:, filename:, length:, file_length:, thumb:,
                 secret: nil, thumb_secret: nil, from: nil, ext: nil)
      jd = { target_type: target_type, target: [*target],
             msg: { type: :video, filename: filename, thumb: thumb, length: length,
                    file_length: file_length, url: url } }
      jd[:msg][:secret] = secret unless secret.nil?
      jd[:msg][:thumb_secret] = thumb_secret unless thumb_secret.nil?
      jd[:from] = from unless from.nil?
      jd[:ext] = ext unless ext.nil?
      request :post, 'messages', json: jd
    end

    def command_to(target, target_type: :users, action:,
                   from: nil, ext: nil)
      jd = { target_type: target_type, target: [*target],
             msg: { type: :cmd, action: action } }
      jd[:from] = from unless from.nil?
      jd[:ext] = ext unless ext.nil?
      request :post, 'messages', json: jd
    end
  end
end
