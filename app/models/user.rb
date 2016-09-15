class User < ApplicationRecord

  has_one :profile
  has_many :pieces
  has_many :deals
  has_and_belongs_to_many :hearts

  accepts_nested_attributes_for :profile, :allow_destroy => true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  before_create :set_default_role

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def full_name
    self.profile.first_name+" "+self.profile.surname
  end

  def has_pieces?
    self.pieces.empty? ? false : true
  end

  def has_hearted?
    hearted = Heart.all.select{|i| i.users.ids.include? self.id }
    hearted.empty? ? false : true
  end

  def owned_deals
    pieces_with_deals = self.pieces.select{ |i| i.deals.exists? }
    all_deals = []
    pieces_with_deals.each {|piece| all_deals << piece.deals}
    all_deals = all_deals.flatten
  end

  def has_open_proposals?
      self.open_proposals.empty? ? false : true
  end


  def open_proposals
    pieces_with_deals = self.pieces.select{ |i| i.deals.exists? }
    return false if pieces_with_deals.nil?
    all_deals = []
    pieces_with_deals.each {|piece| all_deals << piece.deals}
    deals_flattened = all_deals.flatten
    proposals = deals_flattened.select{ |d| ( d[:proposal] == true && d[:accepted] == false )}
  end


  private
    def set_default_role
    self.role_id ||= Role.find_by_name('Member')
  end

end
