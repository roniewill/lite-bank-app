# frozen_string_literal: true

require 'test_helper'

class BankAccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bank_account = bank_accounts(:one)
  end

  test 'should get index' do
    get bank_accounts_url
    assert_response :success
  end

  test 'should get new' do
    get new_bank_account_url
    assert_response :success
  end

  test 'should create bank_account' do
    assert_difference('BankAccount.count') do
      post bank_accounts_url,
           params: { bank_account: { account_number: @bank_account.account_number, balance: @bank_account.balance,
                                     status: @bank_account.status, user_id: @bank_account.user_id } }
    end

    assert_redirected_to bank_account_url(BankAccount.last)
  end

  test 'should show bank_account' do
    get bank_account_url(@bank_account)
    assert_response :success
  end

  test 'should get edit' do
    get edit_bank_account_url(@bank_account)
    assert_response :success
  end

  test 'should update bank_account' do
    patch bank_account_url(@bank_account),
          params: { bank_account: { account_number: @bank_account.account_number, balance: @bank_account.balance,
                                    status: @bank_account.status, user_id: @bank_account.user_id } }
    assert_redirected_to bank_account_url(@bank_account)
  end

  test 'should destroy bank_account' do
    assert_difference('BankAccount.count', -1) do
      delete bank_account_url(@bank_account)
    end

    assert_redirected_to bank_accounts_url
  end
end
