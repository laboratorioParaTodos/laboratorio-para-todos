class AddVigenteToUsuarioPrestamos < ActiveRecord::Migration
  def change
    add_column :usuario_prestamos, :vigente, :boolean
  end
end
