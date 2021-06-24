# frozen_string_literal: true

class BankAccountsController < ApplicationController
  before_action :set_bank_account, only: %i[show edit update destroy change_status]

  # GET /bank_accounts or /bank_accounts.json
  def index
    @bank_accounts = BankAccount.where(user_id: current_user.id).reverse_order
  end

  # GET /bank_accounts/1 or /bank_accounts/1.json
  def show
    @transaction = Transaction.new
    @transactions = Transaction
    .where(account_sender: current_account.account_number)
    .or(Transaction.where(bank_account_id: current_account.id)).reverse_order
  end

  # GET /bank_accounts/new
  def new
    @bank_account = BankAccount.new
  end

  # GET /bank_accounts/1/edit
  def edit; end

  # POST /bank_accounts or /bank_accounts.json
  def create
    @bank_account = BankAccount.new(bank_account_params)

    respond_to do |format|
      if @bank_account.save
        format.html { redirect_to @bank_account, notice: 'Bank account was successfully created.' }
        format.json { render :show, status: :created, location: @bank_account }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bank_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bank_accounts/1 or /bank_accounts/1.json
  def update
    respond_to do |format|
      if @bank_account.update(bank_account_params)
        format.html { redirect_to @bank_account, notice: 'Bank account was successfully updated.' }
        format.json { render :show, status: :ok, location: @bank_account }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bank_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bank_accounts/1 or /bank_accounts/1.json
  def destroy
    @bank_account.destroy
    respond_to do |format|
      format.html { redirect_to bank_accounts_url, notice: 'Bank account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def change_status
    if @bank_account.change_status
      message = @bank_account.active? ? 'Conta ativada com sucesso!' : 'Conta encerrada com sucesso!'
      redirect_to bank_accounts_path, flash: { success: message }
    else
      redirect_to bank_accounts_path, flash: { error: 'Pra encerrar sua conta seu saldo precisa ser 0' }
    end
  end

  private

  def current_account 
    @current_account ||= BankAccount
    .where(user_id: current_user.id)
    .find(params[:id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_bank_account
    @bank_account = BankAccount.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def bank_account_params
    params.require(:bank_account).permit(:balance, :user_id, :status)
  end
end
