# encoding: utf-8

require "openssl"
require "base64"
require "uri"
require "net/http"
require "time"
require "json"
require "securerandom"
require "inifile"
require "pokepay_partner_ruby_sdk/crypto"

module Pokepay
  class Client
    def initialize(inifile_or_hash)
      case inifile_or_hash
      when String then
        path = File.expand_path(inifile_or_hash)
        if File.exist?(path)
          ini = IniFile.load(path)
        else
          raise "init file does not exist."
        end
        @client_id = ini['global']['CLIENT_ID']
        @client_secret = ini['global']['CLIENT_SECRET']
        @api_base_url = URI.parse(ini['global']['API_BASE_URL'])
        @ssl_key_file = ini['global']['SSL_KEY_FILE']
        @ssl_cert_file = ini['global']['SSL_CERT_FILE']
        @timezone = ini['global']['TIMEZONE']
        @timeout = ini['global']['TIMEOUT']
      when Hash then
        @client_id = inifile_or_hash[:client_id]
        @client_secret = inifile_or_hash[:client_secret]
        @api_base_url = URI.parse(inifile_or_hash[:api_base_url])
        @ssl_key_file = inifile_or_hash[:ssl_key_file]
        @ssl_cert_file = inifile_or_hash[:ssl_cert_file]
        @timezone = inifile_or_hash[:timezone]
        @timeout = inifile_or_hash[:timeout]
      end
      @http = Net::HTTP.new(@api_base_url.host, @api_base_url.port)
      if @api_base_url.scheme == 'https'
        @http.use_ssl = true
        @http.cert = OpenSSL::X509::Certificate.new(File.read(@ssl_cert_file))
        @http.key = OpenSSL::PKey::RSA.new(File.read(@ssl_key_file))
        @http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      end
      @crypto = Pokepay::Crypto.new(@client_secret)
    end

    def is_success(res)
      code = res.code.to_i
      200 <= code and code < 300
    end

    def request(request_class, path, body_params, response_class)
      encrypt_data = { 'request_data' => body_params,
                       'timestamp' => Time.now.iso8601(6),
                       'partner_call_id' => SecureRandom.uuid }
      params = {"partner_client_id" => @client_id,
                "data" => Base64.urlsafe_encode64(@crypto.encrypt(JSON.generate(encrypt_data))).tr("=", "")}
      req = request_class.new(path)
      req.set_form_data(params)
      res = @http.start { @http.request(req) }
      res_map = JSON.parse(res.body)
      if(res_map["response_data"]) then
        res.body =
          JSON.parse(@crypto.decrypt(Base64.urlsafe_decode64(res_map["response_data"]))
                       .force_encoding("utf-8"))
      else
        res.body = res_map
      end

      if is_success(res) and response_class
        Pokepay::Response::Response.new(res, response_class.new(res.body))
      else
        res
      end
    end

    def get(path, body_params)
      request(Net::HTTP::Get, path, body_params, nil)
    end

    def post(path, body_params)
      request(Net::HTTP::Post, path, body_params, nil)
    end

    def delete(path, body_params)
      request(Net::HTTP::Delete, path, body_params, nil)
    end

    def patch(path, body_params)
      request(Net::HTTP::Patch, path, body_params, nil)
    end

    def put(path, body_params)
      request(Net::HTTP::Put, path, body_params, nil)
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
      request(request_class, request.path, request.body_params, request.response_class)
    end
  end
end
