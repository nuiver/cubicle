require 'rails_helper'

describe Piece do
  it "is piece without a name" do
    artist = Piece.new(name: "")
    artist.valid?
    expect(artist.errors).to have_key(:name)
  end
end

describe Piece do
  it "is piece without a colour" do
    artist = Piece.new(colour: "")
    artist.valid?
    expect(artist.errors).to have_key(:colour)
  end
end

describe Piece do
  it "is piece without a size" do
    artist = Piece.new(size: "")
    artist.valid?
    expect(artist.errors).to have_key(:size)
  end
end
