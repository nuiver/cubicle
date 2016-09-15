module DealsHelper

  def get_range(piece)
    ranges = []
    if piece.deals.any?
      piece.deals.sort_by{ |i| i[:begin_res] }.each_with_index do | deal, i |
        ranges << {("beg") => (deal.begin_res - 1).strftime("%Y-%B-%d"), ("end") => (deal.end_res + 1).strftime("%Y-%B-%d")}
      end
    end
    ranges.to_json.html_safe
  end

  def get_range_length(piece)
    piece.deals.length.to_s
  end

end
