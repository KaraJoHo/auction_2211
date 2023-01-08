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
end