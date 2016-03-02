class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.all
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new()
    @credit_line = CreditLine.find params[:credit_line_id]
    @transaction = Transaction.new(:credit_line_id => @credit_line.id)
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    puts YAML::dump(transaction_params)
    @transaction = Transaction.new(transaction_params.merge credit_line_id: params[:credit_line_id])
    @credit_line = CreditLine.find(@transaction.credit_line_id)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to credit_line_path(@transaction.credit_line_id), notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
        flash[:redirect] = true
        
        if @transaction.transaction_type.eql?("Payment")
          @credit_line.amount_drawn -= @transaction.amount
        else
          @credit_line.amount_drawn += @transaction.amount
        end
        @credit_line.save
      else
        puts "ELSE"
        format.html { render :action => :new }
        # format.html { redirect_to new_credit_line_transaction_path(@transaction.credit_line_id), notice: 'There were '}
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:transaction_type, :credit_line_id, :amount, :date)
    end
end
