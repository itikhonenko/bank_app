# frozen_string_literal: true

class CreateUsersAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :users_accounts do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :account, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
