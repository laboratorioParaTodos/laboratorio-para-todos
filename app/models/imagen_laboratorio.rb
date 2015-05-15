class ImagenLaboratorio < ActiveRecord::Base
  belongs_to :laboratorio
  mount_uploader :imagen, ImagenUploader
end
