#! /usr/bin/env ruby

class Cashier
  attr_reader :min

  def initialize(currency)
    @currency = currency
    @size = currency.size 
  end

  def get_change(change)
    @min = change
    @time = change
    @time.times do
      puts '----------------'
      value = rand_change(change)
      @min = value if value < @min
    end
  end

  def rand_change(change)
    return 0 if change == 0

    begin
      current = @currency.sample 
    end until current <= change

    puts current
    1 + rand_change(change - current)
  end
end

def main
  currency = [32, 17, 1]
  cashier = Cashier.new(currency)

  change = 68
#  1000.times do 
    cashier.get_change(change)
    puts "answer = #{cashier.min}" #unless cashier.min == 2
#  end
end

main
