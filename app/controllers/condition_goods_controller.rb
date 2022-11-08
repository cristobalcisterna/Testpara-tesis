class ConditionGoodsController < ApplicationController
  before_action :set_condition_good, only: %i[ show edit update destroy ]

  # GET /condition_goods or /condition_goods.json
  def index
    @condition_goods = ConditionGood.all
  end
  
  # GET /condition_goods or /condition_goods.json ###################################################

  def show_request
    @condition_goods = ConditionGood.unscoped{ConditionGood.where(condition_id: 1, activeconditiongood: 1)}
  end

  def show_excluded
    @condition_goods = ConditionGood.unscoped{ConditionGood.where(condition_id: 2, activeconditiongood: 1)}
  end

  def show_lost
    @condition_goods = ConditionGood.unscoped{ConditionGood.where(condition_id: 3, activeconditiongood: 1)}
  end

  def show_destroyed
    @condition_goods = ConditionGood.unscoped{ConditionGood.where(condition_id: 4, activeconditiongood: 1)}
  end

  def showcondition_null
    @condition_goods = ConditionGood.unscoped{ConditionGood.where(activeconditiongood: 0)}
  end

  def showcondition_active
    @condition_goods = ConditionGood.unscoped{ConditionGood.where(activeconditiongood: 1)}
  end

  # GET /condition_goods/1 or /condition_goods/1.json
  def show
  end

  # GET /condition_goods/new
  def new
    @condition_good = ConditionGood.new
  end

  # GET /condition_goods/1/edit
  def edit
  end

  # POST /condition_goods or /condition_goods.json
  def create
    @condition_good = ConditionGood.new(condition_good_params)

    respond_to do |format|
      if @condition_good.save
        format.html { redirect_to @condition_good, notice: "Condition good was successfully created." }
        format.json { render :show, status: :created, location: @condition_good }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @condition_good.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /condition_goods/1 or /condition_goods/1.json
  def update
    respond_to do |format|
      if @condition_good.update(condition_good_params)
        format.html { redirect_to @condition_good, notice: "Condition good was successfully updated." }
        format.json { render :show, status: :ok, location: @condition_good }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @condition_good.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /condition_goods/1 or /condition_goods/1.json
  def destroy
    @condition_good.destroy
    respond_to do |format|
      format.html { redirect_to condition_goods_url, notice: "Condition good was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_condition_good
      @condition_good = ConditionGood.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def condition_good_params
      params.require(:condition_good).permit(:lost_date, :loss_detail, :link, :destruction_date, :destruction_detail, :repairable, :request_date, :request_status, :income_reason, :date_entry, :activeconditiongood, :good_id, :condition_id)
    end
end
