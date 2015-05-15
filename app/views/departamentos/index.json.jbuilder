json.array!(@departamentos) do |departamento|
  json.extract! departamento, :id, :nombre, :descripcion
  json.url departamento_url(departamento, format: :json)
end
