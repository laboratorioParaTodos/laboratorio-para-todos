class AddSemestreToPrestamistas < ActiveRecord::Migration
  def change
    add_column :prestamistas, :semestre, :int
  end
end
