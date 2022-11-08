class GoodsController < ApplicationController
  before_action :set_good, only: %i[ show edit update destroy ]

  # GET /goods or /goods.json
  def index
    @goods = Good.all
  end

  def show_good_dutymanager
    @goods = Good.unscoped{Good.where(duty_manager_id: params[:id],activegood: 1 )}
  end

  def show_good_unit
    @goods = Good.unscoped{Good.joins(:duty_manager).where(duty_managers:{unit_id: params[:id]},activegood: 1)}
  end

  def show_good_office
    @goods = Good.unscoped{Good.where(office_id: params[:id],activegood: 1)}
  end

  def show_good_building
    @goods = Good.unscoped{Good.joins(:office).where(offices:{building_id: params[:id]},activegood: 1)}
  end

  def show_good_user
    @goods = Good.unscoped{Good.joins(:duty_manager).where(duty_managers:{user_id: params[:id]},activegood: 1)}
  end
#current_user
#Función que muestra los bienes anulados
  def show_null
    @goods = Good.unscoped{Good.where(activegood: 0)}
  end

  #Función que muestra los bienes activos
  def show_active
    @goods = Good.unscoped{Good.where(activegood: 1)}
  end

  #Función que muestra los bienes pendientes
  def show_good_pending
    @goods = Good.unscoped{Good.where(activegood: 2)}
  end

  #Función que muestra los bienes en bodega de excluidos
  def show_good_decommissioned
    @goods = Good.unscoped{Good.where(activegood: 3)}
  end


  # GET /goods/1 or /goods/1.json
  def show
  end

  # GET /goods/new
  def new
    @good = Good.new
  end

  # GET /goods/1/edit
  def edit
  end

  # POST /goods or /goods.json
  def create
    @good = Good.new(good_params)

    respond_to do |format|
      if @good.save
        format.html { redirect_to @good, notice: "Good was successfully created." }
        format.json { render :show, status: :created, location: @good }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @good.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /goods/1 or /goods/1.json
  def update
    respond_to do |format|
      if @good.update(good_params)
        format.html { redirect_to @good, notice: "Good was successfully updated." }
        format.json { render :show, status: :ok, location: @good }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @good.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goods/1 or /goods/1.json
  def destroy
    @good.destroy
    respond_to do |format|
      format.html { redirect_to goods_url, notice: "Good was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  # FUNCION PARA VER MI BIEN SELECCIONADO
	def show_my_good
    @good = Good.find params[:id]
		respond_to do |format|
      format.html # index.html.erb
      format.xml  { render xml: @good}
      format.json { render json: @good}
		end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_good
      @good = Good.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def good_params
      params.require(:good).permit(:good_description, :namegood, :identification_number_usach, :identification_number_good, :serie_number, :internal_number, :trademark, :date_purchase, :date_release, :location_good, :duty_manager_id, :office_id, :activegood, :amount, :financial_source_id, :investment_type_id)
    end
end
