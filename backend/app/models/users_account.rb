# frozen_string_literal: true

class UsersAccount < ApplicationRecord
  belongs_to :user
  belongs_to :account
end
