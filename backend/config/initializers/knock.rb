# frozen_string_literal: true

Knock.setup do |config|
  ## Expiration claim
  config.token_lifetime = 1.day

  ## Signature algorithm
  config.token_signature_algorithm = 'HS256'

  ## Signature key
  config.token_secret_signature_key = -> { Rails.application.credentials.secret_key_base }

  ## Exception Class
  config.not_found_exception_class_name = 'ActiveRecord::RecordNotFound'
end
