module Easemob
  module Chatlog
    def chatmessages(after: nil, before: nil, limit: 10, cursor: nil)
      raise ArgumentError, 'Either give after or before, not both when call chatmessages' if after && before
      params = { limit: limit }
      params[:cursor] = cursor unless cursor.nil?
      params[:ql] = "select * where timestamp>#{after.to_i}" unless after.nil?
      params[:ql] = "select * where timestamp<#{before.to_i}" unless before.nil?
      request :get, 'chatmessages', params: params
    end
  end
end
