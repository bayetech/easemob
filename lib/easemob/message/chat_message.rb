require_relative 'base_message'

module Easemob
  class ChatMessage < Easemob::BaseMessage
    def all_success?
      @data.values.all? { |ar| ar == 'success' }
    end
  end
end
