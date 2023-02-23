require './lib/cpu_placement'
require './lib/turn'

class Game
  attr_reader :cpu_board,
              :player_board
  
  def initialize
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2)
    @cpu_cruiser = Ship.new("Cruiser", 3)
    @cpu_submarine = Ship.new("Submarine", 2)
    @battleship = false
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
    p "You currently have a cruser and a submarine!"
    p "If you would like more ships press Y. Press any other key to continue."
    if gets.chomp.upcase == "Y"
      p "Add battleship? Y/N"
      if gets.chomp.upcase == "Y"
        @player_battleship = Ship.new("Battleship", 4)
        @cpu_battleship = Ship.new("Battleship", 4)
        @battleship = true
      elsif gets.chomp.upcase == "N"
      else 
        p "Incorrect input"
      end
    else
    end
    p "Enter desired rows (8-10 recommended)"
    rows = (gets.to_i + 65).chr
    p "Enter desired columns (8-10 recommended)"
    columns = gets.to_i
    @cpu_board = Board.new(rows, columns)
    @player_board = Board.new(rows, columns)
    @cpu_placement_cruiser = CpuPlacement.new(@cpu_cruiser, @cpu_board)
    @cpu_placement_submarine = CpuPlacement.new(@cpu_submarine, @cpu_board)
    @cpu_placement_cruiser.cpu_placement
    @cpu_placement_submarine.cpu_placement
    if @battleship == true
      @cpu_battleship_placement = CpuPlacement.new(@cpu_battleship, @cpu_board)
      @cpu_battleship_placement.cpu_placement 
    end
    puts "I have laid out my ships on the grid.\nYou now need to lay out your two ships.\nThe Cruiser is three units long and the Submarine is two units long."
    print @cpu_board.render
    p "Enter the squares for the Cruiser (3 spaces)"
    if @battleship = true 
      place_player_battleship
    else @battleship = false
      place_player_cruiser
    end
  end

  def place_player_battleship
    input = gets.chomp
    input_array = input.split(" ")
    if input = @player_board.valid_placement?(@player_battleship, input_array)
      @player_board.place(@player_cruiser, input_array)
      @player_board.render(true)
      p "Enter the squares for the Cruiser (3 spaces)"
      place_player_battleship
    else 
      p "Those area invalid coordinates. Please try again (eg: A1 A2 A3 A3):"
      place_player_battleship
    end
    place_player_cruiser
  end
  
  def place_player_cruiser
  input = gets.chomp
  input_array = input.split(" ")
    if input = @player_board.valid_placement?(@player_cruiser, input_array)
      @player_board.place(@player_cruiser, input_array)
      @player_board.render(true)
      p "Enter the squares for the Submarine (2 spaces)"
      place_player_sub
    else 
      p "Those area invalid coordinates. Please try again (eg: A1 A2 A3):"
      place_player_cruiser
    end
  end

  def place_player_sub
  input = gets.chomp
  input_array = input.split(" ")
    if input = @player_board.valid_placement?(@player_submarine, input_array)
      @player_board.place(@player_submarine, input_array)
      @player_board.render(true)
      turn = Turn.new(@cpu_board, @player_board)
      turn.start_turn
    else 
      p "Those are invalid coordinates. Please try again (eg: B1 B2):"
      place_player_sub
    end
  end
end