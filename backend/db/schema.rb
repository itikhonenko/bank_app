# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_221_215_192_412) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'accounts', force: :cascade do |t|
    t.decimal 'balance', precision: 8, scale: 2, default: '0.0'
    t.integer 'account_type', default: 0
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'transactions', force: :cascade do |t|
    t.bigint 'from_account_id'
    t.bigint 'to_account_id'
    t.decimal 'amount', precision: 8, scale: 2
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['from_account_id'], name: 'index_transactions_on_from_account_id'
    t.index ['to_account_id'], name: 'index_transactions_on_to_account_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email'
    t.string 'password_digest'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'users_accounts', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'account_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['account_id'], name: 'index_users_accounts_on_account_id'
    t.index ['user_id'], name: 'index_users_accounts_on_user_id'
  end

  add_foreign_key 'users_accounts', 'accounts'
  add_foreign_key 'users_accounts', 'users'
end
