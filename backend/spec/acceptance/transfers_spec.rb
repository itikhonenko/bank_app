# frozen_string_literal: true

require 'acceptance_helper'

resource 'Transfers' do
  before do
    header 'Accept',       'application/json'
    header 'Content-Type', 'application/json; charset=utf-8'
    authenticated_header.each do |header_name, header_value|
      header header_name.to_s, header_value
    end
  end

  post 'api/v1/transfers' do
    parameter :user_id, required: true
    parameter :amount, required: true

    context '201' do
      let(:current_user) { create :user, :with_accounts }
      let(:recipient) { create :user, :with_accounts }
      let(:raw_post) { params.to_json }
      let(:transfer) { { amount: 1000, user_id: recipient.id } }

      example 'Create Transfer' do
        do_request(transfer)

        expect(status).to eq(201)
      end
    end

    context '422' do
      let(:current_user) { create :user, :with_accounts }
      let(:transfer) { {} }
      let(:raw_post) { params.to_json }

      example 'Create Transfer - errors' do
        do_request(transfer)

        expect(status).to eq(422)
      end
    end
  end
end
