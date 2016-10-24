module PiecesHelper

  def size_match( sz , profile )
    if sz == profile.size || sz == profile.ling_size || sz == profile.shoe_size || sz == profile.letter_size
      true
    end
  end

end
