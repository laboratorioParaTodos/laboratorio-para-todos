class AddRfcToUsuariosPrestamo < ActiveRecord::Migration
  def change
    add_column :usuario_prestamos, :rfc, :string, limit: 16
  end
end
