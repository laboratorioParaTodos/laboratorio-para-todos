class Departamento < ActiveRecord::Base
  #Asociaciones
  has_many :laboratorios
  has_many :usuarios_prestamo
  
  # Retorna los ids de los laboratorios registrados en el departamento
  def laboratorios_id
    laboratorios.all.map { |l| l.id }
  end
end
