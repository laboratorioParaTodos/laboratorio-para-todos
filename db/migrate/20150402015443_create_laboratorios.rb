class CreateLaboratorios < ActiveRecord::Migration
  def change
    create_table :laboratorios do |t|
      t.string :nombre
      t.text :descripcion

      t.timestamps
    end
  end
end
