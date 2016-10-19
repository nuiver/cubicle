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
  UK_SIZES = [4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 'One size']
  BUST_SIZES = ["28", "30", "32", "34", "36", "38", "40", "42", "44", "46"]
  CUP_SIZES = ["AA","A","B","C","D","DD","E","F", "FF", "G"]
  LING_SIZES = BUST_SIZES.map do |b|
    CUP_SIZES.map { |cup| b + cup}
  end.flatten
  TYPES = ['dress', 'jacket', 'jeans', 'jumper', 'cardigan', 'jumpsuit', 'legwear','lingerie', 'shirt', 'shoes', 'shorts', 'skirt', 'swimwear', 'top', 'trousers', 'accessories']
  SUB_DRESS = ['maxi dress', 'midi dress', 'mini dress', 'party dress', 'bodycon dress', 'knitted dress', 'work dress', 'printed dress', 'lace dress']
  SUB_JACKET = ['biker jacket', 'bomber jacket', 'jacket', 'coat', 'parka', 'trench coat', 'leather jacket', 'fur jacket']
  SUB_JEANS = ['cropped & ankle-length', 'regular jeans', 'flared jeans', 'jegging', 'high waisted jeans', 'skinny jeans', 'ripped jeans', ]
  SUB_JUMPER = ['jumpers', 'knitted tops']
  SUB_CARDIGAN = ['cardigans']
  SUB_JUMPSUIT = ['jumpsuit', 'playsuit', 'unitard', 'dungarees']
  SUB_LEGWEAR = ['socks', 'thights', 'knee high socks', 'over the knee socks', 'stay-ups']
  SUB_LINGERIE = ['bra', 'body', 'lingerie set', 'slip', 'brief', 'thong', 'nightwear', 'shapewear']
  SUB_SHIRT = ['blouse', 'shirt']
  SUB_SHOES = ['ankle boots', 'flat shoes', 'flat sandals', 'heeled sandals', 'high heels', 'knee boots', 'over the keen boots', 'pumps', 'slippers', 'trainers' ]
  SUB_SHORTS = ['casual shorts', 'denim shorts', 'tailored shorts', 'leather shorts']
  SUB_SKIRT = ['maxi skirt', 'midi skirt', 'mini skirt', 'A-line skirt', 'pencil skirt', 'pleated skirt', 'skater skirt', 'tulle skirt', 'leather skirt']
  SUB_SWIMWEAR = ['bikini', 'swimsuit', 'beachwear']
  SUB_TOP = ['cami top', 'long sleeve top', 'bandeau top', 'body', 'cold shoulder top', 'crop top', 'knitted top', 't-shirt', 'off shoulder top', 'roll neck top', 'tunic top']
  SUB_TROUSERS = ['skinny trousers', 'tapered trousers', 'wide-leg trousers', 'legging', 'culotte', 'cigarette trousers', 'jogger' ]
  SUB_ACCESSORIES = ['hat', 'cap', 'belt', 'scarve', 'sunglasses']

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
