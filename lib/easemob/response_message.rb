module Easemob
  class ResponseMessage
    attr_reader :raw_http_response, :code, :body, :body_hash

    def initialize(http_response)
      @raw_http_response = http_response
      @code = http_response.code
      @body = http_response.body

      return if http_response.code != 200 \
                || http_response.headers['Content-Type'].index('application/octet-stream')

      @body_hash = JSON.parse(http_response.body.to_s)
      OpenStruct.new(@body_hash)
    end
  end
end
