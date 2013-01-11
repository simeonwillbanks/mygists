module MyGists
  # Public: Performs basic symmetric encryption.
  #
  # Examples
  #
  #   MyGists::Secure.encrypt("password")
  #
  #   MyGists::Secure.decrypt("hmIEj8h1zd5v8W6CTgFM0A==\n")
  class Secure

    # Public: String key that is the same for encrypting and decrypting.
    KEY = Rails.configuration.secret_token

    # Public: Encrypts received data.
    #
    # data - The String of data to encrypt.
    #
    # Examples
    #
    #   MyGists::Secure.encrypt("password")
    #   # => "hmIEj8h1zd5v8W6CTgFM0A==\n"
    #
    # Returns a String of encrypted data.
    def self.encrypt(data)
      new.aes256_encrypt(KEY, data)
    end

    # Public: Decrypts received data that was encrypted by
    #         MyGists::Secure.encrypt.
    #
    # data - The String of data to decrypt.
    #
    # Examples
    #
    #   MyGists::Secure.decrypt("hmIEj8h1zd5v8W6CTgFM0A==\n")
    #   # => "password"
    #
    # Returns a String of decrypted data.
    def self.decrypt(data)
      new.aes256_decrypt(KEY, data)
    end

    # Public: Creates an encrypted UTF-8 String from received key and data.
    #
    # key  - The String secret key for encryption and decryption.
    # data - The String data to be encrypted.
    #
    # Examples
    #
    #   encrypt("key", "password")
    #   # => "hmIEj8h1zd5v8W6CTgFM0A==\n"
    #
    # Returns an encrypted UTF-8 String.
    def aes256_encrypt(key, data)
      c = cipher
      c.encrypt
      c.key = key

      encrypted = c.update(data) + c.final

      Base64.encode64(encrypted).encode(Encoding::UTF_8)
    end

    # Public: Decrypts an encrypted UTF-8 String from received key and data.
    #         The encrypted UTF-8 String must have been encrypted with
    #         #aes256_encrypt.
    #
    # key  - The String secret key for encryption and decryption.
    # data - The encrypted UTF-8 String data.
    #
    # Examples
    #
    #   decrypt("key", "hmIEj8h1zd5v8W6CTgFM0A==\n")
    #   # => "password"
    #
    # Returns an decrypted UTF-8 String.
    def aes256_decrypt(key, data)
      decoded = Base64.decode64(data.encode(Encoding::ASCII_8BIT))

      c = cipher
      c.decrypt
      c.key = key

      c.update(decoded) + c.final
    end

    # Public: Create a AES-128-CBC Ciper instance.
    #
    # Examples
    #
    #   cipher
    #   # => #<OpenSSL::Cipher::AES:0x007fbb3476d3a0>
    #
    # Returns a OpenSSL::Cipher instance.
    def cipher
      OpenSSL::Cipher::AES.new(256, :CBC)
    end
  end
end
