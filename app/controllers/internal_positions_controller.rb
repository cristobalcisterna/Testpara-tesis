class InternalPositionsController < ApplicationController
  before_action :set_internal_position, only: %i[ show edit update destroy ]

  # GET /internal_positions or /internal_positions.json
  def index
    @internal_positions = InternalPosition.all
  end

  # GET /internal_positions/1 or /internal_positions/1.json
  def show
  end

  # GET /internal_positions/new
  def new
    @internal_position = InternalPosition.new
  end

  # GET /internal_positions/1/edit
  def edit
  end

  # POST /internal_positions or /internal_positions.json
  def create
    @internal_position = InternalPosition.new(internal_position_params)

    respond_to do |format|
      if @internal_position.save
        format.html { redirect_to @internal_position, notice: "Internal position was successfully created." }
        format.json { render :show, status: :created, location: @internal_position }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @internal_position.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /internal_positions/1 or /internal_positions/1.json
  def update
    respond_to do |format|
      if @internal_position.update(internal_position_params)
        format.html { redirect_to @internal_position, notice: "Internal position was successfully updated." }
        format.json { render :show, status: :ok, location: @internal_position }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @internal_position.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /internal_positions/1 or /internal_positions/1.json
  def destroy
    @internal_position.destroy
    respond_to do |format|
      format.html { redirect_to internal_positions_url, notice: "Internal position was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_internal_position
      @internal_position = InternalPosition.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def internal_position_params
      params.require(:internal_position).permit(:name, :description, :is_real)
    end
end
