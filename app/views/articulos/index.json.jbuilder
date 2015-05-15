json.array!(@articulos) do |articulo|
  json.extract! articulo, :id, :nombre, :modelo, :laboratorio_id, :numero_de_serie, :numero_de_inventario, :numero_de_sep, :descripcion, :disponible, :motivo, :codigo_de_barras
  json.url articulo_url(articulo, format: :json)
end
