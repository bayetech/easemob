require_relative 'base_message'

module Easemob
  class ChatMessage < Easemob::BaseMessage

    def all_success?
      flag = true
      @data.values.each{ |ar| flag = false and return if ar != 'success' }

      flag
    end
  end
end