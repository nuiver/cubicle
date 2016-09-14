class Deal < ApplicationRecord
  belongs_to :user
  belongs_to :piece

  SHIPPING_METHODS = ['regular postal delivery','priority delivery','I come collect it']

  def self.get_current
    find{ |deal| deal[:begin_res] <= Time.zone.now.beginning_of_day && deal[:end_res] > Time.zone.now.beginning_of_day}
  end
end
