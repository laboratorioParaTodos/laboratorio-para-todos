class CreatePrestamos < ActiveRecord::Migration
  def change
    create_table :prestamos do |t|
      t.references :prestamista, index: true
      t.references :articulo, index: true
      t.date :fecha_de_prestamo
      t.date :fecha_limite
      t.date :fecha_de_devolucion
      t.references :profesor_encargado, index: true
      t.references :materia, index: true

      t.timestamps
    end
  end
end
