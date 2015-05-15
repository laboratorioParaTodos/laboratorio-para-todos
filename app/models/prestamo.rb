class Prestamo < ActiveRecord::Base
  # Asociaciones
  belongs_to :usuario_prestamo
  belongs_to :articulo
  belongs_to :profesor_encargado, class_name: "Prestamista"
  belongs_to :materia
  belongs_to :usuario
  enum estado: [:abierto, :cerrado]
  
  def self.meses
     ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]
  end
  
  def self.filtrar_por_anio(anio) 
    where("YEAR(fecha_de_prestamo) = ?", anio);
  end
  
  def self.filtrar_por_mes(mes) 
    where("MONTH(fecha_de_prestamo) = ?", mes);
  end
  
  def self.filtrar_por_dia(dia)
    where("DAY(fecha_de_prestamo) = ?", dia)
  end
end
