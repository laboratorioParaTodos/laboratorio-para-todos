class CreateImagenArticulos < ActiveRecord::Migration
  def change
    create_table :imagen_articulos do |t|
      t.string :imagen
      t.string :nombre_articulo
      t.string :modelo_articulo
      t.references :laboratorio, index: true
      t.string :tipo_articulo

      t.timestamps
    end
  end
end
