# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Knock::Authenticable

  before_action :authenticate_user

  skip_before_action :verify_authenticity_token, raise: false
end
