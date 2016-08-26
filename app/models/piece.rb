class Piece < ApplicationRecord
  mount_uploader :image, ImageUploader
  mount_uploader :image_b, ImageBUploader
  belongs_to :user
  has_many :periods
  has_many :deals

  COLOURS = ['red', 'orange', 'yellow', 'taupe', 'lime', 'green', 'teal', 'blue', 'navy', 'purple', 'pink', 'brown', 'grey', 'black']
  UK_SIZES = ['6', '8', '10', '12', '14', '16', '18']

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

  def available_now?
    status = false
    self.periods.each do |period|
      if period.begin_date <= Time.zone.now.beginning_of_day && period.end_date > Time.zone.now.beginning_of_day
        status = true
        break
      end
    end
    status
  end

  def sizewarning(user_size)
    user_size != self.size ? true : false
  end


  def first_dates_available
    begin_dates = self.periods.map{|x| x[:begin_date]}
    begin_dates.sort.first
  end

  def self.coloursearch(colour)
    where("colour LIKE ?", "%#{colour[:colour]}%")
  end

  def self.sizesearch(sz)
    where(size: sz[:size])
  end
end
