# frozen_string_literal: true

require 'forwardable'

module Accounts
  class BankAccount
    extend Forwardable

    def_delegators :account, :balance, :id

    attr_reader :current_user

    def initialize(opts, &account_creation_block)
      @current_user = opts[:current_user]
      @account_creation_block = account_creation_block
    end

    def deposit(amount)
      check_amount(amount)

      account.update!(balance: account.balance + amount)
    end

    def withdrawal(amount)
      check_access
      check_balance(amount)
      check_amount(amount)

      account.update!(balance: account.balance - amount)
    end

    private

    # TODO. All checks can be delegated to a separate class and injected as a dependency
    def check_access
      return if account.users.any? { |user| user.id == @current_user.id }

      raise StandardError, 'Transfer is not allowed.'
    end

    def check_balance(amount)
      return if account.balance - amount >= 0

      raise StandardError, 'Insufficient balance'
    end

    def check_amount(amount)
      return if amount.positive?

      raise StandardError, 'Transfer is not allowed.'
    end

    def account
      @account ||= @account_creation_block.call
      return @account if @account

      raise StandardError, 'Transfer is not allowed.'
    end
  end
end
