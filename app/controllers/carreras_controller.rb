class CarrerasController < ApplicationController
  before_action :set_carrera, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_usuario!
  # GET /carreras
  # GET /carreras.json
  def index
    @carreras = Carrera.all
  end

 

  # GET /carreras/new
  def new
    @carrera = Carrera.new
  end

  # GET /carreras/1/edit
  def edit
  end

  # POST /carreras
  # POST /carreras.json
  def create
    @carrera = Carrera.new(carrera_params)

    respond_to do |format|
      if @carrera.save
        format.html { redirect_to carreras_path, notice: 'La carrera fue agregada correctamente.' }
        format.json { render :show, status: :created, location: @carrera }
      else
        format.html { render :new }
        format.json { render json: @carrera.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carreras/1
  # PATCH/PUT /carreras/1.json
  def update
    respond_to do |format|
      if @carrera.update(carrera_params)
        format.html { redirect_to @carrera, notice: 'La carrera fue modificada correctamente.' }
        format.json { render :show, status: :ok, location: @carrera }
      else
        format.html { render :edit }
        format.json { render json: @carrera.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carreras/1
  # DELETE /carreras/1.json
  def destroy
    @carrera.destroy
    respond_to do |format|
      format.html { redirect_to carreras_url, notice: 'La carrera fue destruida correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_carrera
      @carrera = Carrera.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def carrera_params
      params.require(:carrera).permit(:nombre, :departamento_id)
    end
end
