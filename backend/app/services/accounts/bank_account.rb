# frozen_string_literal: true

require 'forwardable'

module Accounts
  class BankAccount
    extend Forwardable

    def_delegators :account, :balance, :id

    attr_reader :account_creation_block

    def initialize(&account_creation_block)
      @account_creation_block = account_creation_block
    end

    def deposit(amount)
      account.update!(balance: balance + amount)
    end

    def withdrawal(amount)
      account.update!(balance: balance - amount)
    end

    def exists?
      account.present?
    end

    private

    def account
      @account ||= @account_creation_block.call
    end
  end
end
