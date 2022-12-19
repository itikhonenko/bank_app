# frozen_string_literal: true

class CreateTransferService
  prepend BaseService

  attr_reader :current_user, :params, :account_class

  def initialize(opts)
    @params = opts[:params]
    @current_user = opts[:current_user]
    @account_class = opts[:account_class] || Accounts::BankAccount
  end

  def call
    contract = validate_contract
    if contract.success?
      proceed_transaction(contract)
    else
      contract.errors.to_h.each { |k, v| add_error(k, v) }
    end
  rescue StandardError
    add_error(:server_error, 'Server error')
  end

  private

  def validate_contract
    Transfer::Contract.new(
      current_user:      current_user,
      sender_account:    sender_account,
      recipient_account: recipient_account
    ).call(params)
  end

  def proceed_transaction(contract)
    ActiveRecord::Base.transaction do
      sender_account.withdrawal(contract[:amount])
      recipient_account.deposit(contract[:amount])
      record_transaction(contract[:amount])
    end
  end

  def sender_account
    @sender_account ||= account_class.new { UsersAccount.find_by(user: current_user)&.account }
  end

  def recipient_account
    @recipient_account ||= account_class.new { UsersAccount.find_by(user_id: params[:user_id])&.account }
  end

  def record_transaction(amount)
    Transaction.create!(
      from_account_id: sender_account.id,
      to_account_id:   recipient_account.id,
      amount:          amount
    )
  end
end
