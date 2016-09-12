class Profile < ApplicationRecord
  belongs_to :user
  validates :first_name, presence: true
  validates :surname, presence: true

  mount_uploader :avatar, AvatarUploader
  
end
