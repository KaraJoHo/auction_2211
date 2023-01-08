class Auction 
  attr_reader :items 

  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def item_names #array of item names 
    @items.map do |item| 
      item.name
    end
  end

  def unpopular_items #array of items with no bids
    @items.find_all do |item| 
      item.bids.empty?
    end
  end

  def items_with_bids #helper method, array of items with bids 
    @items.find_all do |item| 
      item.bids.empty? == false
    end
  end

  def potential_revenue 
    items_with_bids.sum do |item| 
      item.current_high_bid
    end
  end

  def bidders #array of bidders who placed a bid
    items_with_bids.flat_map do |item| 
      item.bids.keys
    end.uniq
  end
end