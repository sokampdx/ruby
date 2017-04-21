class Game
	def initialize
		@rolls = Array.new
		@current_roll = 0
	end

	def roll(pin)
		@rolls.push(pin)
		@current_roll += 1
	end

	def score
		@rolls.inject(:+)
	end	
end
