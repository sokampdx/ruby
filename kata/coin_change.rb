require 'rspec'

class CoinChanger 
  def initialize(coins)
    @coins = coins
  end

  def change(value)
    return 0 if @coins.size == 0
    return 1 if @coins.min >= value
    calculate_change(value)
  end

  def calculate_change(value)
    list = Array.new(@coins.size + 1) { Array.new(value + 1) }  

    (0..@coins.size).each { |i| list[i][0] = 1 }
    (0..value).each { |v| list[0][v] = 0 }

    (1..@coins.size).each do |index|
      (1..value).each do |amount|
        list[index][amount] = list[index - 1][amount] +
          if @coins[index - 1] <= amount
            list[index][amount - @coins[index - 1]]
          else
            0
          end
      end
    end
    list[@coins.size][value]
  end

<<COMMENT
  def calculate_change(value, coin_index = 0)
    return 0 if value < 0
    return 1 if value == 0
    return 0 if coin_index == @coins.size && value > 0

    calculate_change(value - @coins[coin_index], coin_index) + calculate_change(value, coin_index + 1)
  end
COMMENT
end

def coins_string(coins)
  coins.size == 0? 'no' : coins.to_s
end

def assert_change(coins, value, ways)
  it_behaves_like 'a coin changer', coins, value, ways
end

describe CoinChanger do
  shared_examples 'a coin changer' do |coins, value, ways|
    it "initializes with #{coins_string(coins)} coins to make #{ways} ways of change for #{value}" do
      changer = CoinChanger.new(coins)
      expect(changer.change(value)).to eq(ways)
    end
  end

  it 'initializes with coin values' do
    expect(CoinChanger.new([])).to be_truthy
  end

  assert_change([], 10, 0)
  assert_change([1], 0, 1)
  assert_change([1], 1, 1)
  assert_change([1], 2, 1)
  assert_change([1,2], 2, 2)
  assert_change([2,3], 1, 1)
  assert_change([1,2], 3, 2)
  assert_change([1,2], 4, 3)
  assert_change([1,2,3], 5, 5)
  assert_change([1,5,10,25], 100, 242)
end
