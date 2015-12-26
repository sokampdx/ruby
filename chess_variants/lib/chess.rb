require 'pp'
require './game'
require './position'
require './rule'
require './board'

def main(ARGV)
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
