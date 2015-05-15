json.array!(@imagen_laboratorios) do |imagen_laboratorio|
  json.extract! imagen_laboratorio, :id, :imagen, :descripcion, :laboratorio_id
  json.url imagen_laboratorio_url(imagen_laboratorio, format: :json)
end
