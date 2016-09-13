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


  private
    def set_default_role
    self.role_id ||= Role.find_by_name('Member')
  end

end
