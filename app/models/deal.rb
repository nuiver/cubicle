class Deal < ApplicationRecord
  belongs_to :user
  belongs_to :piece

  validates :begin_res, presence: true
  validates :end_res, presence: true

  SHIPPING_METHODS = ['regular postal delivery','priority delivery','I come collect it']
  PAYMENT_METHODS = ['iDEAL','Creditcard','PayPal','Skrill','Bank transfer','Cash (when collected)']

  def self.get_current
    find{ |deal| deal[:begin_res] <= Time.zone.now.beginning_of_day && deal[:end_res] > Time.zone.now.beginning_of_day}
  end

  def accepted?
    self[:accepted] == true ? true : false
  end
  
end
