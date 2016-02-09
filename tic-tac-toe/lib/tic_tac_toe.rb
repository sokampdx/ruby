module Board
  def self.display(moves)
    puts header
    puts divider
    ('a'..'c').zip(0..2).each do |alpha, row|    
      print alpha + "|"
      (0..2).each do |col|
        print moves[row][col] + "|"
      end
      puts
      puts divider
    end
  end

  def self.header
    "  1 2 3 "
  end

  def self.divider
    " -------"
  end

  def self.column
    "| | | |"
  end
end
  

class Game
  def initialize
    @moves = Array.new(3) { Array.new(3, " ") }
    @turn = 1
    @current_player = "X"
  end
  
  def player(turn)
    if turn % 2 == 1
      "X"
    else
      "O"
    end
  end

  def play
    (1..9).each do |turn|
      while @turn == turn && !win?
        Board.disply(@move)
        @current_player = player(turn)
        puts @current_player + "'s move, please enter a move"
        user_input = gets.chomp.to_s
        move(user_input)
      end
    end        
  end 

  def win?
    win = false
    forward_slash = (0..2).collect { |i| @move[i][2-i] }
    back_slash = (0..2).collect { |i| @move[i][i] }   
    
    win = true if is_same?(forward_slash) || is_same?(back_slash)

    unless true
      transposed = @move.transpose
      (0..2).each do |i|
        win = true if is_same?(@move[i]) || is_same?(transposed[i])
      end
    end
    win   
  end

  def is_same?(string)
    string.uniq.length == 1
  end

  def valid_row?
    input_array[0] < "a" || input_array[0] > "c"
  end

  def valid_col?
    input_array[1] < "1" || input_array[1] > "3"
  end

  def valid_length?
    input_move.size >= 0 && input_move.size <= 2
  end

  def validate_within_board(input_move)
    error = "Invalid value for move coordinate."
    if valid_length?
      input_array = input_move.split("")
      return input_array if valid_row? && valid_col?
    end
    puts error 
  end

  def translate(input_array)
    [input_array[0].ord - "a".ord, input_array[1].ord - "1".ord]
  end

  def set_move(input_move, player)
    input_array = validate_within_board(input_move)
    position = translate(input_array)
    current_move = @move[position[0]][position[1]]
    error = "The square has already been played."
    if current_move == " " 
      @move[position[0]][position[1]] = player
      @turn += 1
    else
      puts error
    end
  end

  def move(input_move)
    set_move(input_move, @current_player)
  end
end
