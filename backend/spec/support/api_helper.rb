# frozen_string_literal: true

module ApiHelper
  def json
    JSON.parse(response.body)
  end

  def authenticated_header
    token = Knock::AuthToken.new(payload: { sub: current_user.id }).token

    {
      'Authorization': "Bearer #{token}"
    }
  end
end
