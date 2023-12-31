class Auth
  ALGORITHM = 'HS256'

  class << self
    def encode(payload)
      JWT.encode(payload, auth_secret, ALGORITHM)
    end

    def decode(token)
      JWT.decode(token, auth_secret, true, { algorithm: ALGORITHM }).first
    end

    private

    def auth_secret
      ENV['AUTH_SECRET']
    end
  end
end
