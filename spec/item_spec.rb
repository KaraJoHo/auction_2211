require './lib/item'
require './lib/attendee'

RSpec.describe Item do 
  let(:item1) {Item.new('Chalkware Piggy Bank')}
  let(:item2) {Item.new('Bamboo Picture Frame')}
  let(:item3) {Item.new('Homemade Chocolate Chip Cookies')}
  let(:item4) {Item.new('2 Days Dogsitting')}
  let(:item5) {Item.new('Forever Stamps')}

  let(:attendee1) {Attendee.new(name: 'Megan', budget: '$50')}
  let(:attendee2) {Attendee.new(name: 'Bob', budget: '$75')}
  let(:attendee3) {Attendee.new(name: 'Mike', budget: '$100')}


  describe '#initialize' do 
    it 'exists and has a name' do 
      expect(item1).to be_a(Item)
      expect(item1.name).to eq('Chalkware Piggy Bank')
      expect(item1.bids).to eq({})
    end
  end

  describe '#add_bid' do 
    it 'adds bids to the item' do 
      item1.add_bid(attendee2, 20) 
      item1.add_bid(attendee1, 22) 

      expected = {attendee2 => 20, attendee1 => 22}

      expect(item1.bids).to eq(expected)
    end
  end

  describe '#current_high_bid' do 
    it 'is the highest bid on the item' do 
      item1.add_bid(attendee2, 20) 
      item1.add_bid(attendee1, 22) 

      expect(item1.current_high_bid).to eq(22)
    end
  end

  describe '#close_bidding' do 
    it 'will stop adding bids after closing bidding' do  
      item1.add_bid(attendee2, 20) 
      item1.add_bid(attendee1, 22) 

      expected = {attendee2 => 20, attendee1 => 22}

      expect(item1.closed).to eq(false)

      item1.close_bidding 

      expect(item1.closed).to eq(true)
      expect(item1.bids).to eq(expected)

      item1.add_bid(attendee3, 23)

      expect(item1.bids).to eq(expected)
    end
  end
end