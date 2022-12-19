module Transfer
  class Contract < Dry::Validation::Contract
    option :current_user
    option :sender_account
    option :recipient_account

    params(Transfer::Schema)

    rule(:amount) do
      key.failure('must be greater than 0') if value <= 0
    end

    rule(:sender_account) do
      key.failure('must exist') unless sender_account.exists?
    end

    rule(:user_id, :recipient_account) do
      key.failure('must exist') unless recipient_account.exists?
    end

    rule(:amount, :balance) do
      key.failure('Insufficient balance') if (sender_account.balance - values[:amount]).negative?
    end
  end
end
