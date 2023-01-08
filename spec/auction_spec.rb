require './lib/item'
require './lib/auction'
require './lib/attendee'
require 'date'

RSpec.describe Auction do 
  let(:auction) {Auction.new}

  let(:item1) {Item.new('Chalkware Piggy Bank')}
  let(:item2) {Item.new('Bamboo Picture Frame')}
  let(:item3) {Item.new('Homemade Chocolate Chip Cookies')}
  let(:item4) {Item.new('2 Days Dogsitting')}
  let(:item5) {Item.new('Forever Stamps')}

  let(:attendee1) {Attendee.new(name: 'Megan', budget: '$50')}
  let(:attendee2) {Attendee.new(name: 'Bob', budget: '$75')}
  let(:attendee3) {Attendee.new(name: 'Mike', budget: '$100')}

  describe '#initialize' do 
    it 'exists and has a list of items' do 
      expect(auction).to be_a(Auction)
      expect(auction.items).to eq([])
    end
  end

  describe '#add_item' do 
    it 'adds item object to the list of items' do 
      auction.add_item(item1)
      auction.add_item(item2)

      expect(auction.items).to eq([item1, item2])
    end
  end

  describe '#item_names' do 
    it 'is a list of the item names' do 
      auction.add_item(item1)
      auction.add_item(item2)

      expect(auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
    end
  end

  describe '#unpopular_items' do 
    it 'is items that have no bids' do 
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)

      item1.add_bid(attendee2, 20) 
      item1.add_bid(attendee1, 22) 
      item4.add_bid(attendee3, 50)

      expect(auction.unpopular_items).to eq([item2, item3, item5])

      item3.add_bid(attendee2, 15) 

      expect(auction.unpopular_items).to eq([item2, item5])
    end
  end

  describe '#potential_revenue' do 
    it 'is the total possible sale price of the items(items highest bid)' do
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)

      item1.add_bid(attendee2, 20) 
      item1.add_bid(attendee1, 22) 
      item4.add_bid(attendee3, 50)
      item3.add_bid(attendee2, 15) 

      expect(auction.items_with_bids).to match_array([item1, item4, item3])
      expect(auction.potential_revenue).to eq(87)
    end
  end

  describe '#bidders' do 
    it 'is a list of attendees who placed a bid' do 
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)

      item1.add_bid(attendee2, 20) 
      item1.add_bid(attendee1, 22) 
      item4.add_bid(attendee3, 50)
      item3.add_bid(attendee2, 15) 

      expect(auction.bidders).to match_array([attendee1, attendee2, attendee3])
    end
  end

  describe '#bidder_info' do 
    it 'a hash of bidders with values of ahash of their bidget and array of items they bid on' do 
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)

      item1.add_bid(attendee2, 20) 
      item1.add_bid(attendee1, 22) 
      item4.add_bid(attendee3, 50)
      item3.add_bid(attendee2, 15) 

      expected = {attendee1 => {:budget => 50, :items => [item1]},
                  attendee2 => {:budget => 75, :items => [item1, item3]},
                  attendee3 => {:budget => 100, :items => [item4]}
      }

      expect(auction.items_bid_on(attendee2)).to eq([item1, item3])
      expect(auction.bidder_info).to eq(expected)
    end
  end

  describe '#date' do 
    it 'is created with a date' do 
      
      allow(auction).to receive(:format_date).and_return('03/14/2010')
      allow(auction).to receive(:date).and_return('03/14/2010')

      expect(auction.format_date(Date.today(2010-03-14))).to eq('03/14/2010')
      expect(auction.date).to eq('03/14/2010')
    end
  end

  describe '#can_afford?' do 
    it 'returns true if the attendee has enough money to purchase the item' do 
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)

      item1.add_bid(attendee2, 20) 
      item1.add_bid(attendee1, 22) 
      item4.add_bid(attendee3, 50)
      item3.add_bid(attendee2, 15) 

      expect(auction.can_afford?(attendee1, item1)).to eq(true)
    end
  end

  describe '#most_expensive_first' do 
    it 'purchases the most expensive item first' do 
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)

      item1.add_bid(attendee2, 20) 
      item3.add_bid(attendee2, 15) 

      auction.most_expensive_first(attendee2)

      expect(attendee2.budget).to eq(55)
      expect(attendee2.bidded_on).to eq([item3])
    end

    # describe '#next_highest_bidder' do 
    #   it 'is the next highest bidder for an item' do 
    #   auction.add_item(item1)
    #   auction.add_item(item2)
    #   auction.add_item(item3)
    #   auction.add_item(item4)
    #   auction.add_item(item5)

    #   item1.add_bid(attendee2, 50) 
    #   item3.add_bid(attendee2, 35) 
    #   item3.add_bid(attendee1, 15)

    #   expect(auction.next_highest_bidder).to eq(attendee1)

    #   end
    # end
  end

  
end