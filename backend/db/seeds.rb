# frozen_string_literal: true

if Rails.env.development?
  default_balance = 1000

  users = [
    ['email1@email.com', 'password1'],
    ['email2@email.com', 'password2'],
    ['email3@email.com', 'password3']
  ]

  users.each do |email, password|
    user = User.find_by(email: email) || User.create(email: email, password: password)
    user.accounts.any? || user.accounts.create(balance: default_balance)
  end
end
