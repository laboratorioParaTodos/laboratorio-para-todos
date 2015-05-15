class CreateMaterias < ActiveRecord::Migration
  def change
    create_table :materias do |t|
      t.string :nombre
      t.string :clave
      t.references :carrera, index: true

      t.timestamps
    end
  end
end
