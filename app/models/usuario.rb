class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  belongs_to :laboratorio
  has_many :prestamos
  enum rol: [:encargado_laboratorio, :jefe_laboratorio, :jefe_departamento, :administrador]
  
  def nombre_completo
    nombre.to_s + " " + apellido_paterno.to_s + " " + apellido_materno.to_s
  end
end
