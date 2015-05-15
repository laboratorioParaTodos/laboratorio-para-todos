class ImagenArticulosController < ApplicationController
  before_action :set_imagen_articulo, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_usuario!

  # GET /imagen_articulos
  # GET /imagen_articulos.json
  def index
    @imagen_articulos = ImagenArticulo.all
    
  end

  # GET /imagen_articulos/1
  # GET /imagen_articulos/1.json
  def show
  end

  # GET /imagen_articulos/new
  def new
    @imagen_articulo = ImagenArticulo.new
    if params[:id]
      @articulo = Articulo.find(params[:id]) # TODO Controlar articulos inexistentes
      @imagen_articulo.nombre_articulo = @articulo.nombre
      @imagen_articulo.modelo_articulo = @articulo.modelo
      @imagen_articulo.laboratorio = @articulo.laboratorio
    end
  end

  # GET /imagen_articulos/1/edit
  def edit
  end

  # POST /imagen_articulos
  # POST /imagen_articulos.json
  def create
    @imagen_articulo = ImagenArticulo.new(imagen_articulo_params)
   
    respond_to do |format|
      if @imagen_articulo.save
         if params[:articulo_id]
          @articulo  = Articulo.find(params[:articulo_id])
          @articulo.imagen_articulo = @imagen_articulo
          @articulo.save
          format.html { redirect_to @articulo, notice: 'La imagen fue asignada correctamente al artículo' }
          format.json { render :show, status: :created, location: @imagen_articulo }
        end
      else
        format.html { render :new }
        format.json { render json: @imagen_articulo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /imagen_articulos/1
  # PATCH/PUT /imagen_articulos/1.json
  def update
    respond_to do |format|
      if @imagen_articulo.update(imagen_articulo_params)
        format.html { redirect_to @imagen_articulo, notice: 'Imagen articulo was successfully updated.' }
        format.json { render :show, status: :ok, location: @imagen_articulo }
      else
        format.html { render :edit }
        format.json { render json: @imagen_articulo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /imagen_articulos/1
  # DELETE /imagen_articulos/1.json
  def destroy
    @imagen_articulo.destroy
    respond_to do |format|
      format.html { redirect_to imagen_articulos_url, notice: 'Imagen articulo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_imagen_articulo
      @imagen_articulo = ImagenArticulo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def imagen_articulo_params
      params.require(:imagen_articulo).permit(:imagen, :nombre_articulo, :modelo_articulo, :laboratorio_id, :tipo_articulo)
    end
end
