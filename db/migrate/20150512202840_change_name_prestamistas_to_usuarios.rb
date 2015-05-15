class ChangeNamePrestamistasToUsuarios < ActiveRecord::Migration
  def change
    rename_table :prestamistas, :usuario_prestamos
  end
end
