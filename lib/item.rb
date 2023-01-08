class Item 
  attr_reader :name, :bids

  def initialize(name)
    @name = name
    @bids = {}
  end

  def add_bid(attendee_obj, bid_amount)
   @bids[attendee_obj] = bid_amount
  end

  def current_high_bid 
    @bids.values.max
  end
end