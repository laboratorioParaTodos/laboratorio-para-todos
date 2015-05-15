class ImagenArticulo < ActiveRecord::Base
  belongs_to :laboratorio
  has_many :articulos
  mount_uploader :imagen, ImagenUploader
end
