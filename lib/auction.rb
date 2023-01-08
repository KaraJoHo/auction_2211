require 'date'

class Auction 
  attr_reader :items, :date

  def initialize
    @items = []
    @date = format_date(Date.today)
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

  def bidder_info 
    bidder_info_hash = Hash.new({})

    bidders.each do |bidder|
      bidder_info_hash[bidder] = {:budget => bidder.budget, :items => items_bid_on(bidder)}
    end
    bidder_info_hash
  end

  def items_bid_on(bidder) #array of items the bidder has bid on
    bidder.bidded_on = items_with_bids.find_all do |item|
       item.bids.keys.include?(bidder)
    end
  end

  def format_date(date)
    date.strftime('%d/%m/%Y')
  end

  def can_afford?(bidder, item)
    found_item = items_with_bids.find_all do |item_bid_on| 
      item_bid_on == item
    end.pop

    selected = found_item.bids.select do |attendee, amount| 
      attendee == bidder
    end
    
    bidder.budget > selected.values[0]
  end

  def most_expensive_first(bidder) 
    items_bid_on(bidder)

    most_expensive = bidder.bidded_on.max_by {|item| item.bids.values.max}

    if can_afford?(bidder, most_expensive)
      bidder.spend_money(most_expensive.bids.values[0])
      bidder.bidded_on.delete(most_expensive)
    # else
    #   next_highest_bidder
    end  
  end

  # def next_highest_bidder 
  #   items_with_bids.find do |item| 
  #    
  #   end
  # end
end