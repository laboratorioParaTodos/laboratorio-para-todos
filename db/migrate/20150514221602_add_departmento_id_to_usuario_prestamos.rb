class AddDepartmentoIdToUsuarioPrestamos < ActiveRecord::Migration
  def change
    add_reference :usuario_prestamos, :departamento, index: true
  end
end
