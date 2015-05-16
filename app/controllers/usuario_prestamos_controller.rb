class UsuarioPrestamosController < ApplicationController
  before_action :set_usuario_prestamo, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_usuario!


  # GET /usuario_prestamos
  # GET /usuario_prestamos.json
  def index
    authorize! :ver, UsuarioPrestamo.new
    @usuarios_prestamos = UsuarioPrestamo.all
    @alumnos = UsuarioPrestamo.where(:categoria => UsuarioPrestamo.categorias[:alumno])
    @profesores = UsuarioPrestamo.where(:categoria => UsuarioPrestamo.categorias[:profesor])
    @personal = UsuarioPrestamo.where(:categoria => UsuarioPrestamo.categorias[:personal])
  end

  # GET /usuario_prestamos/1
  # GET /usuario_prestamos/1.json
  def show
    authorize! :ver, @usuario_prestamo
  end

  # GET /usuario_prestamos/new
  def new
    @usuario_prestamo = UsuarioPrestamo.new(categoria: :alumno)
    authorize! :crear, @usuario_prestamo
    if params['categoria']
      @categoria = params['categoria']
      if @categoria == "alumno"
        @usuario_prestamo.categoria = :alumno
      elsif @categoria == "profesor"
        @usuario_prestamo.categoria = :profesor
      elsif @categoria == "personal"
        @usuario_prestamo.categoria = :personal
      end
    end
    @usuario_prestamo.vigente = true # Vigencia verdadera por defecto
  end

  # GET /usuario_prestamos/1/edit
  def edit
    authorize! :editar, @usuario_prestamo
  end

  # POST /usuario_prestamos
  # POST /usuario_prestamos.json
  def create
    @usuario_prestamo = UsuarioPrestamo.new(usuario_prestamo_params)
    authorize! :crear, @usuario_prestamo
    respond_to do |format|
      if @usuario_prestamo.save
        format.html { redirect_to @usuario_prestamo, notice: 'El usuario de préstamo fue agregado correctamente' }
        format.json { render :show, status: :created, location: @usuario_prestamo }
      else
        format.html { render :new }
        format.json { render json: @usuario_prestamo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /usuario_prestamos/1
  # PATCH/PUT /usuario_prestamos/1.json
  def update
    authorize! :editar, @usuario_prestamo
    respond_to do |format|
      if @usuario_prestamo.update(usuario_prestamo_params)
        format.html { redirect_to @usuario_prestamo, notice: 'La información del usuario de préstamos ha sido modificada correctamente' }
        format.json { render :show, status: :ok, location: @usuario_prestamo }
      else
        format.html { render :edit }
        format.json { render json: @usuario_prestamo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usuario_prestamos/1
  # DELETE /usuario_prestamos/1.json
  def destroy
    authorize! :eliminar, @usuario_prestamo
    @usuario_prestamo.destroy
    respond_to do |format|
      format.html { redirect_to usuario_prestamos_url, notice: 'El usuario de préstamo fue eliminado correctamente' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usuario_prestamo
      @usuario_prestamo = UsuarioPrestamo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def usuario_prestamo_params
      params.require(:usuario_prestamo).permit(:primer_nombre, :segundo_nombre, :apellido_paterno, :apellido_materno, :categoria, :carrera_id, :numero_de_control, :rfc, :departamento_id, :vigente)
    end
end
