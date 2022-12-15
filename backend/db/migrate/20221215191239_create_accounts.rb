# frozen_string_literal: true

class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.decimal :balance, precision: 8, scale: 2, default: 0
      t.integer :account_type, default: 0

      t.timestamps
    end
  end
end
