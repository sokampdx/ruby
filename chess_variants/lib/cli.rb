require 'pp'
require './lib/game'
require './lib/position'
require './lib/rule'
require './lib/board'

def is_valid(move)
	true
end

def main
	position = Position.new
	Board.display(position)
	next_move = gets.chomp.to_s
	while is_valid(next_move)
		position.move(next_move[0,2], next_move[2,2])
		Board.display(position)
		next_move = gets.chomp.to_s
	end
end

if __FILE__ == $0
	main
end
