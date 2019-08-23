# encoding: utf-8

require "openssl"
require "base64"
require "uri"
require "net/https"
require "time"
require "json"
require "securerandom"
require "inifile"
require "pokepay_partner_ruby_sdk/crypto"

module Pokepay
  class Client
    def initialize(path_to_inifile)
      ini = IniFile.load(path_to_inifile)
      @client_id = ini['global']['CLIENT_ID']
      @client_secret = ini['global']['CLIENT_SECRET']
      @api_base_url = URI.parse(ini['global']['API_BASE_URL'])
      @ssl_key_file = ini['global']['SSL_KEY_FILE']
      @ssl_cert_file = ini['global']['SSL_CERT_FILE']
      @timezone = ini['global']['TIMEZONE']
      @timeout = ini['global']['TIMEOUT']
      @https = Net::HTTP.new(@api_base_url.host, @api_base_url.port)
      @https.use_ssl = true
      @https.cert = OpenSSL::X509::Certificate.new(File.read(@ssl_cert_file))
      @https.key = OpenSSL::PKey::RSA.new(File.read(@ssl_key_file))
      @https.verify_mode = OpenSSL::SSL::VERIFY_PEER
      @crypto = Pokepay::Crypto.new(@client_secret)
    end

    def request(request_class, path, body_params)
      encrypt_data = { 'request_data' => body_params,
                       'timestamp' => Time.new.iso8601(6),
                       'partner_call_id' => SecureRandom.uuid }
      params = {"partner_client_id" => @client_id,
                "data" => Base64.urlsafe_encode64(@crypto.encrypt(JSON.generate(encrypt_data)))}
      req = request_class.new(path)
      req.set_form_data(params)
      res = @https.start { @https.request(req) }
      # decode response
      res_map = JSON.parse(res.body)
      if(res_map["response_data"])
        res.body = @crypto.decrypt(Base64.urlsafe_decode64(res_map["response_data"]))
                     .force_encoding("utf-8")
      else
        res.body = res_map
      end
      return res
    end

    def get(path, body_params)
      request(Net::HTTP::Get, path, body_params)
    end

    def post(path, body_params)
      request(Net::HTTP::Post, path, body_params)
    end

    def delete(path, body_params)
      request(Net::HTTP::Delete, path, body_params)
    end

    def patch(path, body_params)
      request(Net::HTTP::Patch, path, body_params)
    end

    def put(path, body_params)
      request(Net::HTTP::Put, path, body_params)
    end

    def send(request)
      request_class =  case request.method
                       when "GET" then Net::HTTP::Get
                       when "POST" then Net::HTTP::Post
                       when "DELETE" then Net::HTTP::Delete
                       when "PATCH" then Net::HTTP::Patch
                       when "PUT" then Net::HTTP::Put
                       else raise "Wrong method"
                       end
      request(request_class, request.path, request.body_params)
    end
  end
end

# c = Pokepay::Client.new("/home/wiz/tmp/phpsdk-test/config.ini")

# res = c.send(Pokepay::Request::SendEcho.new('hello'))

# response = c1.post("/echo", {"message" => "hello日本語"})
# puts c1.decode_response(response)
# puts response.code


# response = c1.post("/hoge", {"message" => "hello日本語"})
# puts c1.decode_response(response)
# puts response.code

# response = c1.post("/hoge", {"message" => "hello日本語"})
# puts c1.decode_response(response)
# puts response.code
