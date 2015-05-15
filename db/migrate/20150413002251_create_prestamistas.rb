class CreatePrestamistas < ActiveRecord::Migration
  def change
    create_table :prestamistas do |t|
      t.string :primer_nombre
      t.string :segundo_nombre
      t.string :apellido_paterno
      t.string :apellido_materno
      t.integer :categoria
      t.references :carrera, index: true

      t.timestamps
    end
  end
end
