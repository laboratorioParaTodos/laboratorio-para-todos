class AddAttrToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :rol, :integer
    add_reference :usuarios, :laboratorio, index: true
    add_column :usuarios, :nombre, :string
    add_column :usuarios, :apellido_paterno, :string
    add_column :usuarios, :apellido_materno, :string
    add_column :usuarios, :nombre_usuario, :string
  end
end
