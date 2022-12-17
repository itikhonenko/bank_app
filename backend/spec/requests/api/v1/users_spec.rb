# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  describe 'GET /api/v1/users' do
    let!(:users) { create_list :user, 5 }
    let(:current_user) { create :user }

    it 'receives a list of users' do
      get '/api/v1/users', headers: authenticated_header

      expect(json.size).to eq users.size
    end

    it 'returns 200 status code' do
      get '/api/v1/users', headers: authenticated_header

      expect(response).to have_http_status(:success)
    end
  end
end
