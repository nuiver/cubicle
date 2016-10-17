class Piece < ApplicationRecord
  mount_uploader :image, ImageUploader
  mount_uploader :image_b, ImageBUploader
  belongs_to :user
  has_many :deals
  has_one :heart

  before_create :build_heart

  validates :name, presence: true
  validates :size, presence: true
  validates :colour, presence: true
  validates :begin_date, presence: true
  validates :end_date, presence: true

  COLOURS = ['red', 'orange', 'yellow', 'taupe', 'lime', 'green', 'teal', 'blue', 'navy', 'purple', 'pink', 'brown', 'grey', 'silver', 'black', 'white', 'multi']
  UK_SIZES = [6, 8, 10, 12, 14, 16, 18, 'One size']
  BUST_SIZES = ["28", "30", "32", "34", "36", "38", "40", "42", "44", "46"]
  CUP_SIZES = ["AA","A","B","C","D","DD","E","F", "FF", "G"]
  LING_SIZES = BUST_SIZES.map do |b|
    CUP_SIZES.map { |cup| b + cup}
  end.flatten
  TYPES = ['dress', 'jacket', 'jeans', 'jumper', 'cardigan', 'jumpsuit', 'lingerie', 'shirt', 'shoes', 'shorts', 'skirt', 'swimwear', 'top', 'trousers', 'accessories']

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

  def is_available_now?
    self.begin_date <= Time.zone.now.beginning_of_day && self.end_date > Time.zone.now.beginning_of_day ? true : false
  end

  def self.are_available_now?
    select { |i| i.is_available_now? == true }
  end

  def sizewarning(user_size)
    user_size != self.size ? true : false
  end

  def self.typesearch(type)
    where(product_type: type[:type])
  end

  def self.coloursearch(clr)
    where(colour: clr[:colour])
  end

  def self.sizesearch(sz)
    where(size: sz[:size])
  end

  def self.sort_colours_in_collection(pieces)
    colours = pieces.map{ |i| i[:colour] }.uniq
    sorted_colourlist = []
    COLOURS.map { |col|   (sorted_colourlist << col) if colours.include? col }
    sorted_colourlist
  end

  def self.sort_types_in_collection(pieces)
    types = pieces.map{ |i| i[:product_type] }.uniq
    sorted_typelist = []
    TYPES.map { |tp|   (sorted_typelist << tp) if types.include? tp }
    sorted_typelist
  end

  def self.search(search)
    where("name ILIKE ?", "%#{search}%")
  end


end
