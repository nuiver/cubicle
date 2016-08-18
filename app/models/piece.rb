class Piece < ApplicationRecord
  mount_uploader :image, ImageUploader
  mount_uploader :image_b, ImageBUploader
  belongs_to :user
  has_many :periods
end
