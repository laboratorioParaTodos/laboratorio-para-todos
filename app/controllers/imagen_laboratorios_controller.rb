class ImagenLaboratoriosController < ApplicationController
  before_action :set_imagen_laboratorio, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_usuario!

  # GET /imagen_laboratorios
  # GET /imagen_laboratorios.json
  def index
    @laboratorio = Laboratorio.find(params[:id])  
    authorize! :editar, @laboratorio
    @imagen_laboratorio = ImagenLaboratorio.new
    @imagen_laboratorio.laboratorio = @laboratorio
    
    @imagenes_laboratorios = ImagenLaboratorio.where(:laboratorio_id => @laboratorio.id)
  end

  # GET /imagen_laboratorios/new
  def new
    @imagen_laboratorio = ImagenLaboratorio.new
    @imagen_laboratorio.laboratorio = Laboratorio.find(params[:id])
    authorize! :editar, @imagen_laboratorio.laboratorio
  end

  # GET /imagen_laboratorios/1/edit
  def edit
    authorize! :editar, @imagen_laboratorio.laboratorio
  end

  # POST /imagen_laboratorios
  # POST /imagen_laboratorios.json
  def create
    @imagen_laboratorio = ImagenLaboratorio.new(imagen_laboratorio_params)
    @imagen_laboratorio.laboratorio = Laboratorio.find(imagen_laboratorio_params[:laboratorio_id])  
    authorize! :editar, @imagen_laboratorio.laboratorio
    respond_to do |format|
      if @imagen_laboratorio.save
        format.html { redirect_to imagenes_por_laboratorio_path(@imagen_laboratorio.laboratorio.id), notice: 'La imagen del laboratorio fue añadida correctamente' }
        format.json { render :show, status: :created, location: @imagen_laboratorio }
      else
        format.html { render :new }
        format.json { render json: @imagen_laboratorio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /imagen_laboratorios/1
  # PATCH/PUT /imagen_laboratorios/1.json
  def update    
    authorize! :editar, @imagen_laboratorio.laboratorio
    respond_to do |format|
      if @imagen_laboratorio.update(imagen_laboratorio_params)
        format.html { redirect_to @imagen_laboratorio, notice: 'La imagen del laboratorio fue correctamente modificada.' }
        format.json { render :show, status: :ok, location: @imagen_laboratorio }
      else
        format.html { render :edit }
        format.json { render json: @imagen_laboratorio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /imagen_laboratorios/1
  # DELETE /imagen_laboratorios/1.json
  def destroy
    laboratorio = @imagen_laboratorio.laboratorio
    authorize! :editar, @imagen_laboratorio.laboratorio
    @imagen_laboratorio.destroy
    respond_to do |format|
      format.html { redirect_to imagenes_por_laboratorio_path(laboratorio.id), notice: 'El imagen de laboratorio de elimino correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to sharecommon setup or constraints between actions.
    def set_imagen_laboratorio
      @imagen_laboratorio = ImagenLaboratorio.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def imagen_laboratorio_params
      params.require(:imagen_laboratorio).permit(:imagen, :descripcion, :laboratorio_id)
    end
end
