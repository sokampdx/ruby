require 'pp'

class Game
	PLAYER = [:black, :white]

	def initialize
		@position = Position.new
		@move = 0 
		@turn = 0
	end

	def play(moves)
		moves.each do |m|
			@turn = (@turn + 1) % 2
			@move += @turn
			@position.move(m[0,2], m[2,2])
			puts "Move #{@move} - #{PLAYER[@turn]}" 
			Board.display(@position)
		end
	end
end


class Position
	BACK_ROW = "rnbqkbnr"
	PAWN_ROW = "p"*8

	def initialize
		starting_position = BACK_ROW.upcase + PAWN_ROW.upcase + (" "*8)*4 + PAWN_ROW.downcase + BACK_ROW.downcase
		@position = starting_position.split("")
	end	

	def transform_to_i(coordinate)
		c, r = coordinate.split("")
		col = c.ord - 'a'.ord
		row = r.to_i - 1
		return col, row
	end

	def get(r, c)
		@position[r * 8 + c]
	end

	def move(from, to)
		from_c, from_r = transform_to_i(from)
		to_c, to_r = transform_to_i(to)
		@position[to_c + to_r * 8] = @position[from_c + from_r * 8]
		@position[from_c + from_r * 8] = " "
	end
end

module Rule
	def Rule.castling(position, from, to)
		if position.get(from).downcase == "k" && position.distance(from, to) == 2
			if position.at_long_castle?(from)
				r_from = position.shift(to, -2)
				r_to = position.shift(from, -1)
			elsif position.at_short_castle?(from)
				r_from = position.shift(to, +1)
				r_to = position.shift(from, +1)
			end
				position.move(r_from, r_to)
		end
	end
			
	def Rule.en_passant

	end

end


module Board
	def Board.divider
		" " + "-"*17
	end

	def Board.header
		"  #{('a'..'h').to_a.join(" ")} "
	end

	def	Board.display(location) 
		puts Board.header
		puts Board.divider
		7.downto(0) do |i| 
			print "#{i+1}|"
			(0..7).each do |j|
				print "#{location.get(i,j)}|"
			end
			print "\n#{Board.divider}\n" 
		end
	end
end



def main
	position = Position.new
	Board.display(position)
	position.move("b1", "c3")
	Board.display(position)
end




if __FILE__ == $0
	main
end
