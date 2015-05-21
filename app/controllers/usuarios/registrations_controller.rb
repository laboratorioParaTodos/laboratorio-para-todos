class Usuarios::RegistrationsController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication
  before_filter :authenticate_usuario!
  before_action :authenticate_scope!
  before_filter :configure_sign_up_params, only: [:create]
  before_filter :configure_account_update_params, only: [:update]
  before_action :set_usuario, only: [:editar, :eliminar, :actualizar]
  before_action :set_opciones, only: [:new, :editar]

  # GET /resource/sign_up
  def new
    
    @usuario = Usuario.new(laboratorio: @laboratorio)
    
  end

  
  
  def index
    if(params[:id_laboratorio] && Laboratorio.exists?(params[:id_laboratorio]))
      @laboratorio = Laboratorio.find(params[:id_laboratorio])
      @usuarios = Usuario.where(:laboratorio_id => @laboratorio.id).where.not(:rol => Usuario.roles[:administrador])
      
    else
      @usuarios = Usuario.all.order(:laboratorio_id)   
    end
    @usuarios.each do |u|
        authorize! :ver, u
    end
    
  end
  
  def editar
    
  end
  
  def eliminar
    laboratorio = @usuario.laboratorio
    authorize! :eliminar, @usuario
    if @usuario.destroy
      redirect_to usuarios_sistema_laboratorio_path(laboratorio), notice: "El usuario fue eliminado correctamente"
    end
  end
  
  def actualizar
    authorize! :editar, @usuario
    respond_to do |format|
      if @usuario.update(usuario_params)
        format.html { redirect_to usuarios_sistema_laboratorio_path(@usuario.laboratorio), notice: 'El usuario fue modificado correctamente.' }
        format.json { render :show, status: :ok, location: @usuario }
      else
        format.html { render :edit }
        format.json { render json: @materia.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # You can put the params you want to permit in the empty array.
  def configure_sign_up_params
   devise_parameter_sanitizer.for(:sign_up) << :laboratorio_id << :nombre << :apellido_paterno << :apellido_materno << :nombre_usuario << :rol
  end

  # You can put the params you want to permit in the empty array.
  def configure_account_update_params
    devise_parameter_sanitizer.for(:account_update) << :laboratorio_id << :nombre << :apellido_paterno << :apellido_materno << :nombre_usuario << :rol
  end
  
  def set_usuario
    @usuario = Usuario.find(params[:id])
    
  end
  
  def set_opciones
    if params[:id_laboratorio] && Laboratorio.exists?(params[:id_laboratorio])
      @laboratorio = Laboratorio.find(params[:id_laboratorio])
    end
    @roles = [] # Roles que son asignables por el usuaro
    Usuario.roles.each do |r|
      if can? :crear, Usuario.new(laboratorio: @laboratorio, rol: r[0])
        @roles << r
      end
    end
    @laboratorios = [] # Laboratorios que son asignables por el usuaro
    Laboratorio.all.each do |l|
      if can? :crear, Usuario.new(laboratorio: l, rol: :encargado_laboratorio)
        @laboratorios << l
      end
    end
  end
  
  def usuario_params
      params.require(:usuario).permit(:email, :nombre, :apellido_paterno, :apellido_materno, :laboratorio_id, :rol)
  end
  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end

