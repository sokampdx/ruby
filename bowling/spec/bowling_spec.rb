require './bowling.rb'


describe Game do
	def roll_many(nums, pins)
		nums.times { game.roll(pins) }
	end

  def roll_spare
    roll_many(2, 5)
  end

  def roll_strike
    game.roll(10)
  end

	let(:game) { Game.new }

	it 'rolls all gutter' do
		roll_many(20, 0)
		expect(game.score).to eq(0)
	end	

	it 'rolls all ones' do
		roll_many(20, 1)
		expect(game.score).to eq(20)
	end

	it 'rolls one spare' do
    roll_spare
		game.roll(3)
		roll_many(17, 0)
		expect(game.score).to eq(16)
	end

  it 'rolls one strike' do
    roll_strike
    game.roll(3)
    game.roll(4)
    roll_many(16, 0)
    expect(game.score).to eq(24)
  end  

  it 'rolls perfect game' do
    12.times { roll_strike }
    expect(game.score).to eq(300)
  end

  it 'rolls all gutter except perfect in tenth frame' do
    roll_many(18, 0)
    3.times { roll_strike }
    expect(game.score).to eq(30)
  end
end
