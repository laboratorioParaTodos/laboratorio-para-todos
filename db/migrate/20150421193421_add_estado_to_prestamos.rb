class AddEstadoToPrestamos < ActiveRecord::Migration
  def change
    add_column :prestamos, :estado, :integer
  end
end
