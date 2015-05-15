class Carrera < ActiveRecord::Base
  belongs_to :departamento
  has_many :materias
  validates_presence_of :departamento
end
