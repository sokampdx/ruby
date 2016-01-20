require 'pp'
require './lib/game'
require './lib/position'
require './lib/rule'
require './lib/board'

def main
	position = Position.new
	Board.display(position)
	ARGV.each do |m| 
		position.move(m[0,2], m[2,2])
		Board.display(position)
	end
end

if __FILE__ == $0
	main
end
