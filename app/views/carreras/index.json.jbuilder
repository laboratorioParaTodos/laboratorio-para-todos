json.array!(@carreras) do |carrera|
  json.extract! carrera, :id, :nombre, :departamento_id
  json.url carrera_url(carrera, format: :json)
end
