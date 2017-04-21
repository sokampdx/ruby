class Game
	def initialize
		@rolls = Array.new
		@current_roll = 0
	end

	def roll(pin)
		@rolls[@current_roll] = pin
		@current_roll += 1
	end

	def score
    score = 0
    first_in_frame = 0
    (0...10).map do
      if isStrike(first_in_frame)
        score += 10 + nextTwoBallsAfterStrike(first_in_frame)
        first_in_frame += 1
      elsif isSpare(first_in_frame)
        score += 10 + nextBallAfterSpare(first_in_frame)
        first_in_frame += 2
      else
        score += twoBallsInFrame(first_in_frame) 
        first_in_frame += 2
      end
    end
    score
	end	

  def twoBallsInFrame(first_in_frame)
    @rolls[first_in_frame] + @rolls[first_in_frame + 1]
  end

  def nextBallAfterSpare(first_in_frame)
    @rolls[first_in_frame + 2]
  end

  def nextTwoBallsAfterStrike(first_in_frame)
    @rolls[first_in_frame + 1] + @rolls[first_in_frame + 2]
  end

  def isStrike(first_in_frame)
    @rolls[first_in_frame] == 10
  end

  def isSpare(first_in_frame)
    (@rolls[first_in_frame] + @rolls[first_in_frame + 1]) == 10
  end
end
