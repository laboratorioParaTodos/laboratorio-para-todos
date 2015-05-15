class CreateCarreras < ActiveRecord::Migration
  def change
    create_table :carreras do |t|
      t.string :nombre
      t.references :departamento, index: true

      t.timestamps
    end
  end
end
