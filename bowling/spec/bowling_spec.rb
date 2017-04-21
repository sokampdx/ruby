require './bowling.rb'


describe Game do
	def roll_many(nums, pins)
		nums.times { game.roll(pins) }
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

	xit 'rolls one spare' do
		roll_many(2, 5)
		game.roll(3)
		roll_many(17, 0)
		expect(game.score).to eq(16)
	end
end
