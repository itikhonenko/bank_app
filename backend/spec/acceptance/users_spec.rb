# frozen_string_literal: true

require 'acceptance_helper'

resource 'Users' do
  before do
    header 'Accept',        'application/json'
    header 'Content-Type',  'application/json; charset=utf-8'
    authenticated_header.each do |header_name, header_value|
      header header_name.to_s, header_value
    end
  end

  get 'api/v1/users' do
    let!(:users) { create_list :user, 2 }
    let(:current_user) { create :user }

    context '200' do
      example_request 'Get Users' do
        expect(status).to eq(200)
      end
    end
  end
end
