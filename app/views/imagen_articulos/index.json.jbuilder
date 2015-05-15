json.array!(@imagen_articulos) do |imagen_articulo|
  json.extract! imagen_articulo, :id, :imagen, :nombre_articulo, :modelo_articulo, :laboratorio_id, :tipo_articulo
  json.url imagen_articulo_url(imagen_articulo, format: :json)
end
