# frozen_string_literal: true

class Account < ApplicationRecord
  has_many :transactions_to, foreign_key: 'to_account_id', class_name: 'Transaction', dependent: :nullify
  has_many :transactions_from, foreign_key: 'from_account_id', class_name: 'Transaction', dependent: :nullify
  has_many :users_accounts
  has_many :users, through: :users_accounts

  enum account_type: %i[regular]

  validates :balance, numericality: { greater_than_or_equal_to: 0 }
end
