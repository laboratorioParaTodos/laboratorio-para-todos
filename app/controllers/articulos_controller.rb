class ArticulosController < ApplicationController
  before_action :set_articulo, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_usuario!, except: [:index, :show]

  # GET /articulos
  # GET /articulos.json
  def index
    @laboratorio = Laboratorio.find(params[:id]) 
    
    if(params[:nombre] && params[:modelo])
      @modelo = params[:modelo]
      @articulos = @laboratorio.articulos.buscar_articulo(params[:nombre], params[:modelo])
      @agrupado = false
    else
      @articulos = @laboratorio.articulos.group(:nombre, :modelo).order(:id => :desc)
      @total_por_grupos = @laboratorio.articulos.group(:nombre, :modelo).order(:id => :desc).count
      @agrupado = true
    end
    
  end

  # GET /articulos/1
  # GET /articulos/1.json
  def show
     @imagenes_articulo = @articulo.buscar_imagenes
     @laboratorio = @articulo.laboratorio
  end

  # GET /articulos/new
  def new
    @articulo = Articulo.new
    if params[:id_laboratorio] 
      @laboratorio = Laboratorio.find(params[:id_laboratorio])
      @articulo.laboratorio = @laboratorio
    end
    if params[:codigo_de_barras]
      begin
        @codigo_barras = params[:codigo_de_barras]
        if @laboratorio 
          articulo_base = @laboratorio.articulos.buscar_por_codigo(@codigo_barras)
        else
          articulo_base = Articulo.buscar_por_codigo(@codigo_barras)       
        end
        @articulo = Articulo.obtener_articulo_similar(articulo_base)
      rescue ActiveRecord::RecordNotFound
        flash[:alert] = "No se encontró algún artículo registrado con ese código de barras."
      end
    end
    
  end

  # GET /articulos/1/edit
  def edit
  end

  # POST /articulos
  # POST /articulos.json
  def create
    @articulo = Articulo.new(articulo_params)
    unless(@articulo.buscar_imagen.nil?)
      @articulo.imagen_articulo = @articulo.buscar_imagen
    end
    respond_to do |format|
      if @articulo.save
        if(@articulo.imagen_articulo.nil?)
          format.html { redirect_to agregar_imagen_articulo_path(@articulo), alert: 'No se encontraron imagenes de este tipo de articulo. Seleccione una imagen para subir si desea asignarle una imagen' }
        
        else
          if (params['cantidad'].to_i.between?(0, 50))
            for i in 1..params['cantidad'].to_i - 1
              @articulo = Articulo.obtener_articulo_similar(@articulo)
              @articulo.save
            end
          end
          format.html { redirect_to @articulo, notice: 'El artículo fue agregado correctamente' }
          format.json { render :show, status: :created, location: @articulo }
        end
      else
        format.html { render :new }
        format.json { render json: @articulo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articulos/1
  # PATCH/PUT /articulos/1.json
  def update
    respond_to do |format|
      if @articulo.update(articulo_params)
        format.html { redirect_to @articulo, notice: 'El artículo fue modificado correctamente' }
        format.json { render :show, status: :ok, location: @articulo }
      else
        format.html { render :edit }
        format.json { render json: @articulo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articulos/1
  # DELETE /articulos/1.json
  def destroy
    laboratorio = @articulo.laboratorio
    @articulo.destroy
    respond_to do |format|
      format.html { redirect_to articulos_por_laboratorio_path(laboratorio), notice: 'El artículo fue dado de baja correctamente' }
      format.json { head :no_content }
    end
  end
  
  def asignar_imagen
    imagen = ImagenArticulo.find(params[:id_imagen])
    articulo = Articulo.find(params[:id_articulo])
    articulo.imagen_articulo = imagen
    articulo.save
    redirect_to articulo, notice: "La imagen se ha asignado al artículo correctamente"
    
  end
  
  def agregar_a_prestamo
    if params[:id] 
      id = params[:id]
    else
      if params["codigo_barras"]
        id = Articulo.buscar_por_codigo(params["codigo_barras"]).id.to_s
      end
    end
    if cookies[:articulos_para_prestamo] 
      articulos_para_prestamo = JSON.parse(cookies[:articulos_para_prestamo])
      if (articulos_para_prestamo.index(id).nil?) ## no se encuentra agregadp
        articulos_para_prestamo << id # Controlar cuando no se encuentre el articulo
      end
      cookies[:articulos_para_prestamo] = JSON.generate(articulos_para_prestamo)
    else
      articulos_para_prestamo = [id.to_s]
      cookies[:articulos_para_prestamo] = JSON.generate(articulos_para_prestamo)
    end
    @laboratorio = Articulo.find(id).laboratorio
  end
  
  def eliminar_de_prestamo
    if cookies[:articulos_para_prestamo] 
      articulos_para_prestamo = JSON.parse(cookies[:articulos_para_prestamo])
      articulos_para_prestamo.delete(params[:id_articulo])
      if articulos_para_prestamo.any?
        @laboratorio = Articulo.find(articulos_para_prestamo.first).laboratorio   
        cookies[:articulos_para_prestamo] = JSON.generate(articulos_para_prestamo)
      else
        cookies.delete(:articulos_para_prestamo)
      end
    end
    render 'articulos/agregar_a_prestamo'
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_articulo
      @articulo = Articulo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def articulo_params
      params.require(:articulo).permit(:nombre, :modelo, :laboratorio_id, :numero_de_serie, :numero_de_inventario, :numero_de_sep, :descripcion, :disponible, :motivo)
    end
end
