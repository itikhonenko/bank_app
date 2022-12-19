# frozen_string_literal: true

module Api
  module V1
    class TransfersController < ApplicationController
      def create
        transfer = CreateTransferService.call({ current_user: current_user, params: permitted_params.to_h })

        if transfer.success?
          render json: { result: 'Funds have been transferred' }, status: :created
        else
          render json: transfer.errors, status: :unprocessable_entity
        end
      end

      private

      def permitted_params
        params.permit(:amount, :user_id)
      end
    end
  end
end
