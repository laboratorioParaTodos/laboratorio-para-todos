class Departamento < ActiveRecord::Base
  #Asociaciones
  has_many :laboratorios
  has_many :usuarios_prestamo
end
