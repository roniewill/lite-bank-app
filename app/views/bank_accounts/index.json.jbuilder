# frozen_string_literal: true

json.array! @bank_accounts, partial: 'bank_accounts/bank_account', as: :bank_account
