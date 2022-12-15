# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def index
        users = User.where.not(id: current_user.id)

        render json: users.as_json(only: %i[id email])
      end
    end
  end
end
