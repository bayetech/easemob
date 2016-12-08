module Easemob
  class BaseMessage
    attr_reader :raw_http_response, :code, :body, :body_hash

    attr_reader :timestamp
    attr_reader :duration

    attr_reader :action
    attr_reader :application
    attr_reader :params
    attr_reader :uri
    attr_reader :entities
    attr_reader :data
    attr_reader :organization
    attr_reader :application_name
    attr_reader :cursor
    attr_reader :count

    attr_reader :error
    attr_reader :exception
    attr_reader :error_description

    def initialize(http_response)
      @raw_http_response = http_response
      @code = http_response.code
      @body = http_response.body

      return unless http_response.headers['Content-Type'].index('application/json')

      @body_hash = JSON.parse(@body)

      @timestamp = @body_hash['timestamp']
      @duration = @body_hash['duration']

      if http_response.code == 200
        @action = @body_hash['action']
        @application = @body_hash['application']
        @params = @body_hash['params']
        @uri = @body_hash['uri']
        @entities = @body_hash['entities']
        @data = @body_hash['data']
        @organization = @body_hash['organization']
        @application_name = @body_hash['applicationName']
        @cursor = @body_hash['cursor']
        @count = @body_hash['count']
      else
        @error = @body_hash['error']
        @exception = @body_hash['exception']
        @error_description = @body_hash['error_description']
      end
    end

    def to_s
      @body.to_s
    end

    def inspect
      "#{self.class.name}(code: #{@code}, body: #{@body}, action: #{@action},
       application: #{@application}, params: #{@params}, uri: #{@uri}, entities: #{@entities},
       data: #{@data}, timestamp: #{@timestamp}, duration: #{@duration}, organization: #{@organization},
       applicationName: #{@applicationName}, cursor: #{@cursor}, count: #{@count})"
    end
  end
end
