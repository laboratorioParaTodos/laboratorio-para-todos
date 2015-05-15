json.array!(@prestamistas) do |prestamista|
  json.extract! prestamista, :id, :primer_nombre, :segundo_nombre, :apellido_paterno, :apellido_materno, :categoria, :carrera_id
  json.url prestamista_url(prestamista, format: :json)
end
