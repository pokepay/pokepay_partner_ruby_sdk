module Pokepay::Response
  class Response < Net::HTTPResponse
    def initialize(response)
      @code = response.code
      response_map = JSON.parse(response.body)
      if(response_map["response_data"])
        @crypto.decrypt(Base64.urlsafe_decode64(response_map["response_data"])).force_encoding("utf-8")

    end
    attr_reader :path
    attr_reader :method
    attr_reader :body_params
  end
end
