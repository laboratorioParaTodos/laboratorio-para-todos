class PrestamosController < ApplicationController
  before_action :set_prestamo, only: [:show, :edit, :update, :destroy, :cerrar_prestamo]
  before_action :set_laboratorio, only: [:index, :new, :prestamos_abiertos]
  before_action :authenticate_usuario!
  # GET /prestamos
  # GET /prestamos.json
  def index
    @date = Date.today
    @prestamos = @laboratorio.prestamos
    @periodos = {anio: false, mes: false, fecha: false}
    
    unless params["todos"]
        if params["periodo(1i)"]
          anio = params["periodo(1i)"].to_i
          @date = @date.change(year: anio)
        end
        @prestamos = @prestamos.filtrar_por_anio(@date.year)
        unless params["anio"] 
          if params[params["periodo(2i)"]]
            mes = params["periodo(2i)"].to_i
            @date = @date.change(month: mes)
          end
          @prestamos = @prestamos.filtrar_por_mes(@date.month)
          unless params["mes"]
            if params["periodo(3i)"]
              dia = params["periodo(3i)"].to_i
              @date = @date.change(day: dia)
            end
            @prestamos = @prestamos.filtrar_por_dia(@date.day)
            @periodos[:fecha] = true
            @tipo_periodo = :dia
          else
            @periodos[:mes] =  true
            @tipo_periodo = :mes
          end
        else
          @periodos[:anio] = true
          @tipo_periodo = :anio
        end
    else
      @periodos[:anio] = true
      @tipo_periodo = :todos
    end
   
    
    
  end
  
  def prestamos_abiertos
    @prestamos = @laboratorio.prestamos.where(:estado => Prestamo.estados[:abierto]).order(fecha_de_prestamo: :desc)
  end
  
  def cerrar_prestamo 
    if @prestamo.estado == :cerrado
      redirect_to prestamos_abiertos_path(@prestamo.articulo.laboratorio), alert: "El préstamo ya se encuentra cerrado"
    else 
      if(@prestamo.update(estado: :cerrado, fecha_de_devolucion: Date.today) && @prestamo.articulo.update(disponible: true, motivo: nil))
        redirect_to prestamos_abiertos_path(@prestamo.articulo.laboratorio), notice: "El préstamo se cerró correctamente"
      else
        redirect_to prestamos_abiertos_path(@prestamo.articulo.laboratorio), alert: "Error al cerrar el préstamo"
      end
    end
  end

  # GET /prestamos/1
  # GET /prestamos/1.json
  def show
  end

  # GET /prestamos/new
  def new
    @prestamo = Prestamo.new  
    @articulos = @laboratorio.articulos.where(disponible: true)
    if params[:id_usuario_prestamo]
      @id_busqueda_usuario = params[:id_usuario_prestamo]
      if UsuarioPrestamo.exists?(numero_de_control: @id_busqueda_usuario)
        @prestamo.usuario_prestamo = UsuarioPrestamo.find_by(numero_de_control: @id_busqueda_usuario)
      end
    end
    # TODO Agregar RFC

  end

  # GET /prestamos/1/edit
  def edit
    @articulos = @prestamo.articulo.laboratorio.articulos.where(disponible: true)
  end

  # POST /prestamos
  # POST /prestamos.json
  def create
    @articulos = []
    errores = false
    laboratorio = nil
    articulos_correctos = [] # ID de articulos guardados correctamente para eliminarse despues de las cookies
    if (params['articulos_acumulados'])
      if cookies[:articulos_para_prestamo]
        articulos_prestamo = JSON.parse(cookies[:articulos_para_prestamo]) # id de articulos a registrar
        articulos_prestamo = articulos_prestamo.uniq #Eliminar duplicados
        articulos_prestamo.each do |id_articulo|
          if Articulo.exists?(id_articulo)
            articulo = Articulo.find(id_articulo) 
            @prestamo = Prestamo.new(prestamo_params)           
            @prestamo.estado = :abierto
            @prestamo.articulo = articulo
            @prestamo.usuario = current_usuario
            if @prestamo.save           
              articulos_correctos << @prestamo.articulo.id # Eliminar del arreglo de articulos acumulados si se salvo el prestamo
            end
            @prestamo.articulo.disponible = false
            @prestamo.articulo.motivo = "En préstamo"
            @prestamo.articulo.save
            if laboratorio.nil?
              laboratorio = @prestamo.articulo.laboratorio
            end
            @articulos << articulo
          end
        end
        articulos_correctos.each do |ac|
          articulos_prestamo.delete(ac.to_s) # Eliminar del arreglo los articulos que se registraron correctamente
        end
        puts 'Articulos_correctos: ' + articulos_correctos.to_s
        puts 'Articulos_prestamo: ' + articulos_prestamo.to_s
        unless articulos_prestamo.any?
          cookies.delete(:articulos_para_prestamo) # Eliminar cookies si el array esta vacio
        else
          cookies[:articulos_para_prestamo] = JSON.generate(articulos_prestamo)
        end
      end
    end
    
    respond_to do |format|
        unless errores
          format.html { redirect_to registrar_prestamo_path(laboratorio.id), notice: 'El préstamo fue correctamente registrado' }
          format.json { render :show, status: :created, location: @prestamo }      
        else
          format.html { render :new }
          format.json { render json: @prestamo.errors, status: :unprocessable_entity }
        end
    end
  end

  # PATCH/PUT /prestamos/1
  # PATCH/PUT /prestamos/1.json
  def update
    respond_to do |format|
      if @prestamo.update(prestamo_params)
        format.html { redirect_to @prestamo, notice: 'Prestamo was successfully updated.' }
        format.json { render :show, status: :ok, location: @prestamo }
      else
        format.html { render :edit }
        format.json { render json: @prestamo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prestamos/1
  # DELETE /prestamos/1.json
  def destroy
    laboratorio = @prestamo.articulo.laboratorio
    @prestamo.destroy
    respond_to do |format|
      format.html { redirect_to prestamos_registrados_path(laboratorio.id), notice: 'El préstamo fue eliminado correctamente' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prestamo
      @prestamo = Prestamo.find(params[:id])
    end
    
    def set_laboratorio    
      @laboratorio = Laboratorio.find(params[:laboratorio_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prestamo_params
      params.require(:prestamo).permit(:usuario_prestamo_id, :articulo_id, :fecha_de_prestamo, :fecha_limite, :fecha_de_devolucion, :profesor_encargado_id, :materia_id)
    end
    
    
end
