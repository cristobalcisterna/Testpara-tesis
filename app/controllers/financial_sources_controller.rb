class FinancialSourcesController < ApplicationController
  before_action :set_financial_source, only: %i[ show edit update destroy ]

  # GET /financial_sources or /financial_sources.json
  def index
    @financial_sources = FinancialSource.all
  end

  def show_null_financial_source
    @financial_sources = FinancialSource.unscoped{FinancialSource.where(active_financial_source: 0)}
  end

  def show_active_financial_source
    @financial_sources = FinancialSource.unscoped{FinancialSource.where(active_financial_source: 1)}
  end


  # GET /financial_sources/1 or /financial_sources/1.json
  def show
  end

  # GET /financial_sources/new
  def new
    @financial_source = FinancialSource.new
  end

  # GET /financial_sources/1/edit
  def edit
  end

  # POST /financial_sources or /financial_sources.json
  def create
    @financial_source = FinancialSource.new(financial_source_params)

    respond_to do |format|
      if @financial_source.save
        format.html { redirect_to @financial_source, notice: "Financial source was successfully created." }
        format.json { render :show, status: :created, location: @financial_source }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @financial_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /financial_sources/1 or /financial_sources/1.json
  def update
    respond_to do |format|
      if @financial_source.update(financial_source_params)
        format.html { redirect_to @financial_source, notice: "Financial source was successfully updated." }
        format.json { render :show, status: :ok, location: @financial_source }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @financial_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /financial_sources/1 or /financial_sources/1.json
  def destroy
    @financial_source.destroy
    respond_to do |format|
      format.html { redirect_to financial_sources_url, notice: "Financial source was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_financial_source
      @financial_source = FinancialSource.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def financial_source_params
      params.require(:financial_source).permit(:name_financial_source, :detail, :active_financial_source)
    end
end
