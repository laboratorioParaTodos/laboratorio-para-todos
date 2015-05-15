json.array!(@prestamos) do |prestamo|
  json.extract! prestamo, :id, :prestamista_id, :articulo_id, :fecha_de_prestamo, :fecha_limite, :fecha_de_devolucion, :profesor_encargado_id, :materia_id
  json.url prestamo_url(prestamo, format: :json)
end
