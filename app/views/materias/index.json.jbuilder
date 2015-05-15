json.array!(@materias) do |materia|
  json.extract! materia, :id, :nombre, :clave, :carrera_id
  json.url materia_url(materia, format: :json)
end
