class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  belongs_to :laboratorio
  has_many :prestamos
  enum rol: [:administrador, :jefe_laboratorio, :encargado_laboratorio]
  
  def nombre_completo
    nombre + " " + apellido_paterno + " " + apellido_materno
  end
end
