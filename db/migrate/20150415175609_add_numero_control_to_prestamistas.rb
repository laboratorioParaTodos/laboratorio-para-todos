class AddNumeroControlToPrestamistas < ActiveRecord::Migration
  def change
    add_column :prestamistas, :numero_de_control, :string
  end
end
