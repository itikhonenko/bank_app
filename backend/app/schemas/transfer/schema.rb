module Transfer
  Schema = Dry::Schema.Params do
    required(:user_id).filled(Types::Params::Integer)
    required(:amount).filled(Types::JSON::Decimal)

    optional(:sender_account)
    optional(:recipient_account)
    optional(:balance)
  end
end
