class AddImagenArticuloToArticulos < ActiveRecord::Migration
  def change
    add_reference :articulos, :imagen_articulo, index: true
  end
end
