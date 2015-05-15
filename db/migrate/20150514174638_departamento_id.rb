class DepartamentoId < ActiveRecord::Migration
  def change
    add_reference(:laboratorios, :departamento, index: true, foreign_key: true, null: false)
  end
end
