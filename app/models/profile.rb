class Profile < ApplicationRecord
  belongs_to :user
  before_create :build_profile
  accepts_nested_attributes_for :profile
  mount_uploader :image, ImageUploader
end
