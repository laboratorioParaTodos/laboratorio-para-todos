class UsuarioPrestamo < ActiveRecord::Base 
  has_many :prestamos
  belongs_to :carrera
  belongs_to :departamento
  enum categoria: [:alumno, :profesor, :personal]
  
  def nombre_completo
    nombre = primer_nombre + " " + segundo_nombre + " " + apellido_paterno + " " + apellido_materno
    nombre.sub "  ", " "
  end
end
