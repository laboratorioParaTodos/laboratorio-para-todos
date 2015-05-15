class CreateImagenLaboratorios < ActiveRecord::Migration
  def change
    create_table :imagen_laboratorios do |t|
      t.string :imagen
      t.text :descripcion
      t.references :laboratorio, index: true

      t.timestamps
    end
  end
end
