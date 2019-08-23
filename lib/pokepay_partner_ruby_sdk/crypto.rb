# encoding: utf-8

require "openssl"
require "base64"
require "securerandom"

module Pokepay
  class Crypto
    def initialize(key)
      @key = Base64.urlsafe_decode64(key).force_encoding("utf-8")
      @cipher = OpenSSL::Cipher.new('AES-256-CBC')
    end

    def encrypt(plaintext)
      enc = @cipher
      enc.encrypt
      enc.key = @key
      enc.padding = 1
      enc.iv = SecureRandom.random_bytes(16)
      enc.update('0'*16 + plaintext) + enc.final
    end

    def decrypt(ciphertext)
      dec = @cipher
      dec.decrypt
      dec.key = @key
      dec.iv  = ciphertext.byteslice(0,16)
      decrypted_text = dec.update(ciphertext) + dec.final
      decrypted_text.byteslice(16, decrypted_text.bytesize - 16)
    end
  end
end
