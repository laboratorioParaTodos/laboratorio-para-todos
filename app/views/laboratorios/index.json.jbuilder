json.array!(@laboratorios) do |laboratorio|
  json.extract! laboratorio, :id, :nombre, :descripcion
  json.url laboratorio_url(laboratorio, format: :json)
end
