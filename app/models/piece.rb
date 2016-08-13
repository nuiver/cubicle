class Piece < ApplicationRecord
  mount_uploader :image, ImageUploader
end
