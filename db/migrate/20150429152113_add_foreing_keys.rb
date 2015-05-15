class AddForeingKeys < ActiveRecord::Migration
  def change
    add_foreign_key :articulos, :laboratorios, dependent: :delete
    add_foreign_key :prestamos, :articulos
    add_foreign_key :prestamistas, :carreras
    add_foreign_key :articulos, :imagen_articulos
    add_foreign_key :prestamos, :prestamistas, dependent: :delete
    add_foreign_key :prestamos, :prestamistas, column: :profesor_encargado_id
    add_foreign_key :prestamos, :materias
    add_foreign_key :materias, :carreras
    add_foreign_key :carreras, :departamentos
    add_foreign_key :imagen_laboratorios, :laboratorios, dependent: :delete
  end
end
