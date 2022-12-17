# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Transfers API', type: :request do
  describe 'POST /api/v1/transfers' do
    let(:user_account) { create :users_account }
    let(:recipient_account) { create :users_account }
    let(:current_user) { user_account.user }

    context 'with valid params' do
      let(:valid_params) { { amount: 1000, user_id: recipient_account.user.id } }

      it 'returns 201 status code' do
        post '/api/v1/transfers', params: valid_params, headers: authenticated_header

        expect(response).to have_http_status(:created)
      end
    end

    context 'with a non-existent recipient' do
      let(:valid_params) { { amount: 1000, user_id: 'fake-id' } }

      it 'returns 422 status code' do
        post '/api/v1/transfers', params: valid_params, headers: authenticated_header

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when the balance is less than the transfer amount' do
      let(:invalid_params) do
        {
          amount: recipient_account.account.balance + 1000,
          user_id: recipient_account.user.id
        }
      end

      it 'returns 422 status code' do
        post '/api/v1/transfers', params: invalid_params, headers: authenticated_header

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
