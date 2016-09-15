module DealsHelper

  def get_range(piece)
    ranges = []
    if piece.deals.any?
      piece.deals.sort.each_with_index do | deal, i |
        ranges << {("beg") => deal.begin_res.strftime("%Y-%B-%d"), ("end") => deal.end_res.strftime("%Y-%B-%d")}
      end
    end

    ranges.to_json.html_safe
  end

  def get_range_length(piece)
    piece.deals.length.to_s
  end

end
