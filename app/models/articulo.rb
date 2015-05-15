class Articulo < ActiveRecord::Base
  belongs_to :laboratorio
  belongs_to :imagen_articulo
  
  searchkick language: "Spanish"
  
  #TODO Validar descripcion del articulo a 200 caracteres maximo
  
  def buscar_imagen 
    imagen = ImagenArticulo.where(nombre_articulo: nombre, modelo_articulo: modelo, laboratorio_id: laboratorio.id).last
  end
  
  def buscar_imagenes
    imagen = ImagenArticulo.where(nombre_articulo: nombre, modelo_articulo: modelo, laboratorio_id: laboratorio.id)
  end
  
  # Busca un articulo por su codigo de barras
  def self.buscar_por_codigo(codigo)
    id = codigo.split("-").last # Dvidir el codigo por los guiones, la ultima sección es el id
    find(id)
  end
  
  def get_imagen
    if imagen_articulo.nil?
      return "/uploads/imagen no disponible.jpg"
    else
      imagen_articulo.imagen.url
    end
  end
  
  def obtener_codigo_barras
    codigo_tecnologico = 11 # TODO ambiar a variable
    
    codigo_tecnologico.to_s + "-" + laboratorio.id.to_s.rjust(2, "0") + "-" + id.to_s.rjust(6, "0")
  end
  
  def self.buscar_articulo(nombre, modelo)
    Articulo.where(nombre: nombre, modelo: modelo)
  end
  
  # Retorna un artículo nuevo basado en uno anterior
  def self.obtener_articulo_similar(articulo)
    # Atributos que tomara el artículo
    atributos = [:nombre, :modelo, :laboratorio, :numero_de_inventario, :numero_de_sep, :descripcion, :imagen_articulo]
    Articulo.new(nombre: articulo.nombre, modelo: articulo.modelo, laboratorio: articulo.laboratorio,
     numero_de_inventario: articulo.numero_de_inventario, numero_de_sep: articulo.numero_de_sep, 
     descripcion: articulo.descripcion, imagen_articulo: articulo.imagen_articulo, disponible: true)
  end
  
end
