require './lib/item'
require './lib/auction'

RSpec.describe Auction do 
  let(:auction) {Auction.new}

  let(:item1) {Item.new('Chalkware Piggy Bank')}
  let(:item2) {Item.new('Bamboo Picture Frame')}

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
      expect(auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
    end
  end
end