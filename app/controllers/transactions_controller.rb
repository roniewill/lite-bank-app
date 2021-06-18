# frozen_string_literal: true

class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[show edit update destroy]
  before_action :set_account_collections

  # GET /transactions or /transactions.json
  def index
    @transactions = Transaction.all
  end

  # GET /transactions/1 or /transactions/1.json
  def show; end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
    @account_number = params[:account_number]
    @balance = BankAccount.find_by(account_number: params[:account_number])&.balance
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /transactions/1/edit
  def edit; end

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        flash[:success] = 'Operação efetuado com sucesso'
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.js { render 'success' }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.js { render :new }
      end
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.js { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.js { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def set_account_collections
    @accounts = BankAccount.all.collect {|p| [ "#{p.account_number} - #{p.user.name}", p.id ]}
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction).permit(:bank_account_id, :amount, :transaction_type, :transaction_number, :account_sender)
  end
end
