
class Game
  PLAYER = [:white, :black]

  def initialize(ai = 0)
    @position = Position.new
    @nmoves = 1 
    @turns = 0
		@move_list = []
#		@rule = Rule.new
		@in_check = {:black => false, :white => false}
		@checkmate = {:black => false, :white => false}
#		@ai = AIPlayer.new(ai % 2)
  end 

	def display_board
		puts "Move #{@nmoves} - #{PLAYER[@turns]}" 
		Board.display(@position)
	end

	def increment_stat	
		@turns = (@turns + 1) % 2 
		@nmoves += 1 if @turns == 0
	end

  def replay(moves)
    moves.each do |m|
			from, to = Game.find_from_and_to_square(m)
      @position.move(from, to)
			display_board
			increment_stat 
    end 
  end 

	def Game.find_from_and_to_square(move)
		return move[0,2], move[2,2]
	end

	def make_a_move(move)
		from, to = Game.find_from_and_to_square(move)
		verify_moving_same_side_piece(from)
		verify_landing_not_on_own_piece(to)
		verify_valid_piece_movement(from, to)
		@move_list << move
		@nturn = (@nturn + 1) % 2
		@nmoves += @nturn
	end

	def in_check?
		@in_check[PLAYER[@turns]]
	end

	def game_not_done?
		true	
	end	

	def play
		while game_not_done?
			print "Check! " if in_check?
			puts "#{PLAYER[@turns].to_s} to move:"
			move = gets.chomp
			make_a_move(move)
		end

		puts result
	end

	def result
		if @checkmate[:black]
			"White win!"
		elsif @checkmate[:white]
			"Black win!"
		else
			"Draw game."
		end
	end
end

