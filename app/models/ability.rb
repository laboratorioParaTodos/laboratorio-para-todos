class Ability
  include CanCan::Ability

  def initialize(usuario)
    usuario ||= Usuario.new
    alias_action :crear, :editar, :ver, :eliminar, :generar_codigo, :to => :gestionar
    
    if usuario.administrador?
      can :manage, :all # Privilegios totales
    else
      can :ver, [Articulo, Laboratorio] # Privilegio para todos los usuarios
      if usuario.encargado_laboratorio? || usuario.jefe_laboratorio? || usuario.jefe_departamento?
        # Privilegios que comparten el encargado de laboratorio, jefe de laboratorio y el jefe de departamento
        can [:crear, :generar_codigo], Articulo, :laboratorio_id => usuario.laboratorio.id
        can [:crear, :ver], UsuarioPrestamo
        can [:crear, :cerrar, :editar], Prestamo, :articulo => { :laboratorio_id => usuario.laboratorio.id }
        can :ver, Prestamo, :articulo => { :laboratorio_id => usuario.laboratorio.id }
        
        if usuario.jefe_laboratorio? || usuario.jefe_departamento?
          # Privilegios exclusivos para el jefe de laboratorio y el jefe de departamento
          can :gestionar, Articulo, :laboratorio_id => usuario.laboratorio.id
          can :gestionar, UsuarioPrestamo
          can :gestionar, Prestamo, :articulo => { :laboratorio_id => usuario.laboratorio.id }
          can :agregar, Usuario # Permiso para acceder a la venta agregar
          can :gestionar, Usuario, {:rol => ["encargado_laboratorio", "jefe_laboratorio"], :laboratorio_id => usuario.laboratorio.id}
          can :ver, Usuario, :laboratorio_id => usuario.laboratorio.id
          can :eliminar, ImagenArticulo
          can :editar, Laboratorio, :id => usuario.laboratorio.id
          if usuario.jefe_laboratorio?
            cannot [:editar, :eliminar], Usuario, :rol => ["jefe_laboratorio"]
          end
          
          if usuario.jefe_departamento?
            # Privilegios exclusivos para el jefe de departamento
            can :gestionar, Articulo, :laboratorio_id => usuario.laboratorio.departamento.laboratorios_id
            can :cerrar, Prestamo, :articulo => { :laboratorio_id => usuario.laboratorio.departamento.laboratorios_id }
            can :gestionar, Prestamo, :articulo => { :laboratorio_id => usuario.laboratorio.departamento.laboratorios_id }
            can :gestionar, Usuario, :rol => [ "encargado_laboratorio", "jefe_laboratorio", "jefe_departamento"], :laboratorio_id => usuario.laboratorio.departamento.laboratorios_id 
            can :gestionar, Laboratorio, :id => usuario.laboratorio.departamento.laboratorios_id
            
            can :gestionar, Materia, :carrera => { :departamento_id => usuario.laboratorio.departamento.id }
            cannot [:editar, :eliminar],Usuario, :rol => "jefe_departamento"
          end
          
        end
      end
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
