class CreateArticulos < ActiveRecord::Migration
  def change
    create_table :articulos do |t|
      t.string :nombre
      t.string :modelo
      t.references :laboratorio, index: true
      t.string :numero_de_serie
      t.string :numero_de_inventario
      t.string :numero_de_sep
      t.text :descripcion
      t.boolean :disponible
      t.text :motivo
      t.string :codigo_de_barras

      t.timestamps
    end
  end
end
