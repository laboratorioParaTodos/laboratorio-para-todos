class RenameUsuariosPrestamosToUsuarioPrestamos < ActiveRecord::Migration
  def change
    rename_table :usuarios_prestamos, :usuario_prestamos
  end
end
