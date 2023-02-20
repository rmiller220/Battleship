require './lib/board'
class Game
  def initialize(comp_board, player_board)
    @comp_board = comp_board
    @player_board = player_board
    @comp_cruiser = Ship.new("Cruiser", 3)
   
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
    # @board.cpu_placement
    print "I have laid out my ships on the grid.\nYou now need to lay out your two ships.\nThe Cruiser is three units long and the Submarine is two units long."
    @board.render
    print "Enter the squares for the Cruiser (3 spaces):"
    # input = gets.chomp 
    #    if input = @board.place(cruiser, )
    #     print "Ship is placed"
    #     @board.render(true)
    #    else 
    #     print "Invalid placement, try again"
    #    end
    #     if input = board.place(submarin, coordinates)
   
  end
  def place_cpu_ships
    comp_place_cruiser = @comp_board.valid_placement.sample
    @comp_board.place(@comp_cruiser, comp_place_cruiser)
    
end