class MateriasController < ApplicationController
  before_action :set_materia, only: [:show, :edit, :update, :destroy]
  before_action :set_carreras, only: [:new, :edit]
  before_action :authenticate_usuario!

  # GET /materias
  # GET /materias.json
  def index
    @materias = Materia.all
    authorize! :ver, Materia.new
    if params['carrera']
      if Carrera.exists?(params['carrera'])      
        @materias = Carrera.find(params['carrera']).materias
      end
    end
  end

  # GET /materias/new
  def new
    @materia = Materia.new
    if params[:id_laboratorio] && Laboratorio.exists?(params[:id_laboratorio])
      @laboratorio = Laboratorio.find(params[:id_laboratorio])
      @materia.carrera = Carrera.new(departamento: @laboratorio.departamento)
    end
    authorize! :crear, @materia
  end

  # GET /materias/1/edit
  def edit
    authorize! :editar, @materia
  end

  # POST /materias
  # POST /materias.json
  def create
    @materia = Materia.new(materia_params)
    authorize! :crear, @materia
    respond_to do |format|
      if @materia.save
        format.html { redirect_to materias_path, notice: 'La materia fue agregada correctamente' }
        format.json { render :show, status: :created, location: @materia }
      else
        format.html { render :new }
        format.json { render json: @materia.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /materias/1
  # PATCH/PUT /materias/1.json
  def update
    authorize! :editar, @materia
    respond_to do |format|
      if @materia.update(materia_params)
        format.html { redirect_to @materia, notice: 'Materia was successfully updated.' }
        format.json { render :show, status: :ok, location: @materia }
      else
        format.html { render :edit }
        format.json { render json: @materia.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /materias/1
  # DELETE /materias/1.json
  def destroy
    authorize! :eliminar, @materia
    @materia.destroy
    respond_to do |format|
      format.html { redirect_to materias_url, notice: 'Materia was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_materia
      @materia = Materia.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def materia_params
      params.require(:materia).permit(:nombre, :clave, :carrera_id)
    end
    
    def set_carreras
      @carreras = Carrera.all # TODO Filtrar por privilegios
    end
end
