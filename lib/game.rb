class Game
  def initialize
   
  end

  def start
    puts "Welcome to BATTLESHIP\nEnter p to play. Enter q to quit."
    input = gets.chomp.downcase
    if input == "p"
      p "Let's Play!"
      start_game
    elsif input == "q"
      p "See you next time"
      exit 
    else
      p "Invalid input. Please try again."
      start
    end
  end

  # def start_game
  #   cpu_placement
  # end

  
end