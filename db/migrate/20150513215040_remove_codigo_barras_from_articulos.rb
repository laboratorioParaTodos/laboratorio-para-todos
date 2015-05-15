class RemoveCodigoBarrasFromArticulos < ActiveRecord::Migration
  def change
    remove_column :articulos, :codigo_de_barras
  end
end
