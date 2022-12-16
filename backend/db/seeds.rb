# frozen_string_literal: true

if Rails.env.development?
  [
    ['email1@email.com', 'password1'],
    ['email2@email.com', 'password2'],
    ['email3@email.com', 'password3']
  ].map do |email, password|
    user = User.find_by(email: email) || User.create(email: email, password: password)
    user.accounts.any? || user.accounts.create(balance: 1000)
  end
end
