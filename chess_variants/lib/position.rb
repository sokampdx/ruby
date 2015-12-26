
class Position
  BACK_ROW = "rnbqkbnr"
  PAWN_ROW = "p"*8

  def initialize
    starting_position = BACK_ROW.upcase + PAWN_ROW.upcase + (" "*8)*4 + PAWN_ROW.downcase + BACK_ROW.downcase
    @position = starting_position.split("")
  end

  def Position.square_to_index(coordinate)
    c, r = coordinate.split("")
    col = c.ord - 'a'.ord
    row = r.to_i - 1
    return Position.row_col_to_index(row, col)
  end

	def Position.index_to_square(index)
		row, col = Position.index_to_row_col(index)
		c = ('a'.ord + col).chr
		r = (row + 1).to_s
		return [c, r].join
	end

	def Position.row_col_to_index(row, col)
		row * 8 + col
	end

	def Position.index_to_row_col(index)
		col = index % 8
		row = index / 8 
		return row, col
	end	

	def find(piece)
		index = @position.each_index.select { |i| @position[i] == piece }
		locations = index.map do |i|
			Position.index_to_square(i)
		end
		puts locations.to_s
	end

  def get(r, c)
    @position[Position.row_col_to_index(r, c)]
  end

	def get_square(location)
		index = Position.square_to_index(location)
		@position[index]
	end

	def Position.distance_col(from, to)
		(from[0].ord - to[0].ord).abs
	end

	def Position.distance_row(from, to)
		(from[1].to_i - to[1].to_i).abs
	end

	def is_castling?(from, to)
		Position.distance_col(from, to) == 2 && get_square(from).downcase == "k"
	end

	def is_en_passant?(from, to)
		Position.distance_col(from, to) == 1 && get_square(from).downcase == "p" && get_square(to) == " "
	end

  def move(from, to, piece=" ")
    from_index = Position.square_to_index(from)
    to_index = Position.square_to_index(to)
		castling(from, to) if is_castling?(from, to)
		en_passant(from, to) if is_en_passant?(from, to)
    @position[to_index] = @position[from_index]
    @position[from_index] = piece
		self
  end

	def is_white?
		self == self.upcase
	end

	def is_black?
		self == self.downcase
	end

	def castling(from, to)
		row = from[1]
		if from > to
			r_from = "a" + row
			r_to = "d" + row
		else
			r_from = "h" + row
			r_to = "f" + row
		end
		move(r_from, r_to)
	end

	def en_passant(from, to)
		row = from[1]
		col = to[0]
		index = Position.row_col_to_index(row, col)
		@position[index] = " "
	end
end

