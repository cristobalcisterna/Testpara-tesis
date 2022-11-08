class BuildingsController < ApplicationController
  before_action :set_building, only: %i[ show edit update destroy ]

  # GET /buildings or /buildings.json
  def index
    @buildings = Building.all
  end

  def show_building_unit
    @buildings = Building.unscoped{Building.where(unit_id: params[:id],active_building: 1)}
  end

  def show_null_building
    @buildings = Building.unscoped{Building.where(active_building: 0)}
  end

  def show_active_building
    @buildings = Building.unscoped{Building.where(active_building: 1)}
  end

  def show_building_duty_manager
    @buildings = Building.unscoped{Building.where(duty_manager_id: params[:id],active_building: 1)}
  end

  def show_building_user
    @buildings = Building.unscoped{Building.joins(:duty_manager).where(duty_managers:{user_id: params[:id]},active_building: 1)}
  end


  # GET /buildings/1 or /buildings/1.json
  def show
  end

  # GET /buildings/new
  def new
    @building = Building.new
  end

  # GET /buildings/1/edit
  def edit
  end

  # POST /buildings or /buildings.json
  def create
    @building = Building.new(building_params)

    respond_to do |format|
      if @building.save
        format.html { redirect_to @building, notice: "Building was successfully created." }
        format.json { render :show, status: :created, location: @building }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @building.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /buildings/1 or /buildings/1.json
  def update
    respond_to do |format|
      if @building.update(building_params)
        format.html { redirect_to @building, notice: "Building was successfully updated." }
        format.json { render :show, status: :ok, location: @building }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @building.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buildings/1 or /buildings/1.json
  def destroy
    @building.destroy
    respond_to do |format|
      format.html { redirect_to buildings_url, notice: "Building was successfully destroyed." }
      format.json { head :no_content }
    end
  end


   # FUNCION PARA VER MI EDIFICIO SELECCIONADO
	def show_my_building
    @building = Building.find params[:id]
		respond_to do |format|
      format.html # index.html.erb
      format.xml  { render xml: @building}
      format.json { render json: @building}
		end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_building
      @building = Building.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def building_params
      params.require(:building).permit(:name_building, :identification_number_building, :location_building, :duty_manager_id, :active_building, :unit_id)
    end
end
