# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :users_accounts
  has_many :accounts, through: :users_accounts

  validates :email, presence: true, uniqueness: true
end
