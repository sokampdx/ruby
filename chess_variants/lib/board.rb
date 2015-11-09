
module Board
  def Board.divider
    " " + "-"*17
  end 

  def Board.header
    "  #{('a'..'h').to_a.join(" ")} "
  end 

  def Board.display(location) 
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


