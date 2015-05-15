class RenamePrestamistaPrestamos < ActiveRecord::Migration
  def change
    rename_column :prestamos, :prestamista_id, :usuario_prestamo_id
  end
end
