class Item 
  attr_reader :name, :bids, :closed

  def initialize(name)
    @name = name
    @bids = {} 
    @closed = false
  end

  def add_bid(attendee_obj, bid_amount)
   if @closed == false 
    @bids[attendee_obj] = bid_amount
   end
  end

  def current_high_bid 
    @bids.values.max
  end

  def close_bidding 
    @closed = true
  end
end