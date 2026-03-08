class JwtService
  SECRET    = ENV.fetch("JWT_SECRET", "development_jwt_secret")
  ALGORITHM = "HS256".freeze
  EXPIRY    = 24.hours

  def self.encode(payload)
    payload = payload.merge(exp: EXPIRY.from_now.to_i)
    JWT.encode(payload, SECRET, ALGORITHM)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET, true, { algorithm: ALGORITHM })
    HashWithIndifferentAccess.new(decoded.first)
  rescue JWT::DecodeError, JWT::ExpiredSignature => e
    raise AuthenticationError, e.message
  end
end
