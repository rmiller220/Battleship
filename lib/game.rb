require './lib/cpu_placement'
class Game
  
  def initialize
    @cpu_board = Board.new
    @player_board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @cpu_placement_cruiser = CpuPlacement.new(@cruiser, @cpu_board)
    @cpu_placement_submarine = CpuPlacement.new(@submarine, @cpu_board)
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
  

  def start_game
    @cpu_placement_cruiser.cpu_placement
    @cpu_placement_submarine.cpu_placement
    p "I have laid out my ships on the grid.\nYou now need to lay out your two ships.\nThe Cruiser is three units long and the Submarine is two units long."
    @cpu_board.render
    p "Enter the squares for the Cruiser (3 spaces)"
    place_player_cruiser
  end
  
  # def place_player_cruiser
  # input = gets.chomp
  #   if input = @player_board.valid_coordinate? && @player_board.place
  #     @player_board.render(true)
  #     p "Enter the squares for the Submarine (2 spaces)"
  #     place_player_sub
  #   else 
  #     p "Those area invalid coordinates. Please try again:"
  #     place_player_cruiser
  #   end
  # end

  # def place_player_sub
  # input = gets.chomp
  #   if input = @player_board.valid_coordinate? && @player_board.place
  #     @player_board.render(true)
  #     start_turn
  #   else 
  #     p "Those are invalid coordinates. Please try again:"
  #     place_player_sub
  #   end
  # end
end