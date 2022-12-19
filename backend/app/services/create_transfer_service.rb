# frozen_string_literal: true

class CreateTransferService
  prepend BaseService

  attr_reader :current_user, :account_class, :amount, :user_id

  def initialize(opts)
    @amount = opts[:params][:amount].to_d
    @user_id = opts[:params][:user_id]
    @current_user = opts[:current_user]
    @account_class = opts[:account_class] || Accounts::BankAccount
  end

  def call
    ActiveRecord::Base.transaction do
      sender_account.withdrawal(amount)
      recipient_account.deposit(amount)
      record_transaction
    end
  rescue StandardError => e
    add_error(:error, e.message)
  end

  private

  def sender_account
    account_class.new({ current_user: current_user }) do
      current_user.accounts.regular.take
    end
  end

  def recipient_account
    account_class.new({ current_user: current_user }) do
      UsersAccount.find_by(user_id: user_id)&.account
    end
  end

  def record_transaction
    Transaction.create!(
      from_account_id: sender_account.id,
      to_account_id:   recipient_account.id,
      amount:          amount
    )
  end
end
