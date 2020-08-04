class InvestmentsController < ApplicationController
  # before_action :set_investment, only: [:show, :edit, :update, :destroy]

  # GET /investments
  # GET /investments.json
  def index
    @investments = current_user.investments.all
  end

  # GET /investments/1
  # GET /investments/1.json
  # def show
  # end

  # GET /investments/new
  def new
    @product = Product.find(params[:product_id])
    @investment = Investment.new
  end

  # GET /investments/1/edit
  # def edit
  # end

  # POST /investments
  # POST /investments.json
  def create
    @investment = current_user.investments.new(investment_params)
    @investment.product_id = params[:product_id]
    # params[:product_id]でproduct_idを受け取れる
    respond_to do |format|
      if @investment.save
        format.html { redirect_to product_investments_path, notice: 'Investment was successfully created.' }
        format.json { render :show, status: :created, location: @investment }
      else
        format.html { render :new }
        format.json { render json: @investment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /investments/1
  # PATCH/PUT /investments/1.json
  # def update
  #   respond_to do |format|
  #     if @investment.update(investment_params)
  #       format.html { redirect_to @investment, notice: 'Investment was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @investment }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @investment.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /investments/1
  # DELETE /investments/1.json
  # def destroy
  #   @investment.destroy
  #   respond_to do |format|
  #     format.html { redirect_to investments_url, notice: 'Investment was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_investment
      @investment = Investment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def investment_params
      params.require(:investment).permit(:price)
    end
end
