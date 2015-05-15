class Laboratorio < ActiveRecord::Base
  #Asociaciones
  has_many :imagen_laboratorios
  has_many :articulos
  has_many :usuarios
  belongs_to :departamento
  
  # Validaciones
  validates :nombre, :presence => { message: "%{value} No puede estar vacío"}, uniqueness: {message: "Laboratorio duplicado"}
  validates :descripcion, length: { maximum: 500, message: "La descripción no puede exceder los 500 carácteres"}
  
  
  def prestamos
    Prestamo.where(articulo_id: Articulo.select(:id).where(laboratorio_id: id))
  end
end
