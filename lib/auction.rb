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
end