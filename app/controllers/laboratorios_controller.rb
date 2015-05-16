class LaboratoriosController < ApplicationController
  before_action :set_laboratorio, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_usuario!, except: [:show, :index]

  # GET /laboratorios
  # GET /laboratorios.json
  def index
    @departamentos = Departamento.all.order(:nombre)
  end

  # GET /laboratorios/1
  # GET /laboratorios/1.json
  def show
    @imagenes = @laboratorio.imagen_laboratorios
  end

  # GET /laboratorios/new
  def new
    @laboratorio = Laboratorio.new
    authorize! :crear, @laboratorio
  end

  # GET /laboratorios/1/edit
  def edit
    authorize! :editar, @laboratorio
  end

  # POST /laboratorios
  # POST /laboratorios.json
  def create
    @laboratorio = Laboratorio.new(laboratorio_params)
    authorize! :crear, @laboratorio
    respond_to do |format|
      if @laboratorio.save
        format.html { redirect_to @laboratorio, notice: 'El laboratorio se creó correctamente' }
        format.json { render :show, status: :created, location: @laboratorio }
      else
        format.html { render :new }
        format.json { render json: @laboratorio.errors, status: :unprocessable_entity }
      end
    end
    
  end

  # PATCH/PUT /laboratorios/1
  # PATCH/PUT /laboratorios/1.json
  def update
    authorize! :editar, @laboratorio
    respond_to do |format|
      if @laboratorio.update(laboratorio_params)
        format.html { redirect_to @laboratorio, notice: 'El laboratorio fue correctamente modificado.' }
        format.json { render :show, status: :ok, location: @laboratorio }
      else
        format.html { render :edit }
        format.json { render json: @laboratorio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /laboratorios/1
  # DELETE /laboratorios/1.json
  def destroy
    authorize! :eliminar, @laboratorio
    @laboratorio.destroy
    respond_to do |format|
      format.html { redirect_to laboratorios_url, notice: 'El laboratorio fue eliminado correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_laboratorio
      @laboratorio = Laboratorio.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def laboratorio_params
      params.require(:laboratorio).permit(:nombre, :descripcion, :departamento_id)
    end
end
