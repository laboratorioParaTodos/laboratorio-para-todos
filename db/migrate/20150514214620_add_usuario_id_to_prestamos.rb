class AddUsuarioIdToPrestamos < ActiveRecord::Migration
  def change
    add_reference :prestamos, :usuario, index: true, null: false
  end
end
