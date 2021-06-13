# frozen_string_literal: true

json.extract! transaction, :id, :bank_account_id, :amount, :transaction_type, :transaction_number, :created_at,
              :updated_at
json.url transaction_url(transaction, format: :json)
