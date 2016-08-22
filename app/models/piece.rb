class Piece < ApplicationRecord
  mount_uploader :image, ImageUploader
  mount_uploader :image_b, ImageBUploader
  belongs_to :user
  has_many :periods

  def self.order_by_new
    order(updated_at: :desc)
  end

  def self.not_owned_by(id)
    where.not(user: id)
  end

  def self.added_today
    where("created_at >= ?", Time.zone.now.beginning_of_day)
  end

  def self.not_added_today
    where("created_at < ?", Time.zone.now.beginning_of_day)
  end

end
