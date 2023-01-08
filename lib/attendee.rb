class Attendee 
  attr_reader :name, :budget
  attr_accessor :bidded_on

  def initialize(attributes)
    @name = attributes[:name]
    @budget = attributes[:budget].delete('$').to_i
    @bidded_on = []
  end

  def spend_money(amount) 
    @budget -= amount
  end

  # def bidded_on 
  #   []
  # end
end