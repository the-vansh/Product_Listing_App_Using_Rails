class JwtService
  def self.encode(user_id)
    payload = {
      user_id: user_id,
      exp: 24.hours.from_now.to_i
    }

    JWT.encode(
      payload,
      Rails.application.credentials.jwt_secret,
      "HS256"
    )
  end

  def self.decode(token)
    JWT.decode(
      token,
      Rails.application.credentials.jwt_secret,
      true,
      { algorithm: "HS256" }
    )
  end
end
