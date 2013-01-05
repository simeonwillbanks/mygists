module MyGists
  class Secure
    KEY = Rails.configuration.secret_token

    def self.encrypt(data)
      new.aes256_encrypt(KEY, data)
    end

    def self.decrypt(data)
      new.aes256_decrypt(KEY, data)
    end

    def aes256_encrypt(key, data)
      c = cipher
      c.encrypt
      c.key = key
      encrypted = c.update(data) + c.final
      Base64.encode64(encrypted).encode(Encoding::UTF_8)
    end

    def aes256_decrypt(key, data)
      decoded = Base64.decode64(data.encode(Encoding::ASCII_8BIT))
      c = cipher
      c.decrypt
      c.key = key
      c.update(decoded) + c.final
    end

    def cipher
      OpenSSL::Cipher::AES.new(256, :CBC)
    end
  end
end
