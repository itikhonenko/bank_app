# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.bigint :from_account_id, index: true, foreign_key: true
      t.bigint :to_account_id, index: true, foreign_key: true
      t.decimal :amount, precision: 8, scale: 2

      t.timestamps
    end
  end
end
