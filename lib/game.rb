require './lib/cpu_placement'
require './lib/turn'

class Game
  attr_reader :cpu_board,
              :player_board
  
  def initialize
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2)
    @player_battleship = Ship.new("Battleship", 3)
    @cpu_cruiser = Ship.new("Cruiser", 3)
    @cpu_submarine = Ship.new("Submarine", 2)
    @cpu_battleship = Ship.new("Battleship", 3)
    @player_carrier = Ship.new("Carrier", 3)
    @cpu_carrier = Ship.new("Carrier", 3)
    @battleship = false
    @carrier = false
  end

  def start
    puts "Welcome to BATTLESHIP\nEnter p to play. Enter q to quit."
    input = gets.chomp.downcase
    if input == "p"
      p "Let's Play!"
      battleship_select
    elsif input == "q"
      p "See you next time"
      exit 
    else
      p "Invalid input. Please try again."
      start
    end
  end

  def battleship_select
    p "Do you want more ships? Y for yes N for no!"
    if gets.chomp.upcase == "Y" 
      p "Do you want a battleship? Y for yes N for no!"
      if gets.chomp.upcase == "Y"
        @battleship = true
        carrier_select
      elsif 
        gets.chomp.upcase == "N"
        carrier_select
      else
        p "Incorrect input, try again."
        battleship_select
      end
    elsif gets.chomp.upcase == "N"
      p "Ok lets select our grid size!"
      start_game
    else 
      p "Incorrect input, try again."
      battleship_select
    end
  end

  def carrier_select
    p "Do you want a carrier? Y for yes N for no!"
    if gets.chomp.upcase == "Y"
      @carrier = true
      start_game
    elsif gets.chomp.upcase == "N"
      p "Ok lets select our grid size!"
      start_game
    else 
      p "Incorrect input, try again"
      carrier_select
    end
  end
  
  def start_game
    p "Enter desired rows (8-10 recommended)"
    rows = (gets.to_i + 65).chr
    p "Enter desired columns (8-10 recommended)"
    columns = gets.to_i
    @cpu_board = Board.new(rows, columns)
    @player_board = Board.new(rows, columns)
    @cpu_placement_cruiser = CpuPlacement.new(@cpu_cruiser, @cpu_board)
    @cpu_placement_submarine = CpuPlacement.new(@cpu_submarine, @cpu_board)
    @cpu_placement_battleship = CpuPlacement.new(@cpu_battleship, @cpu_board)
    @cpu_placement_carrier = CpuPlacement.new(@cpu_carrier, @cpu_board)
    @cpu_placement_cruiser.cpu_placement
    @cpu_placement_submarine.cpu_placement
    puts "I have laid out my ships on the grid.\nYou now need to lay out your ships"
    print @cpu_board.render
    place_player_carrier
  end

  def place_player_carrier
    if @carrier == false
      place_player_battleship
    end
    @cpu_placement_carrier.cpu_placement
    p "Enter the coordinates for the Carrier (3 spaces eg A1 A2 A3)"
    input = gets.chomp
    input_array = input.split(" ")
    if input = @player_board.valid_placement?(@player_carrier, input_array)
      @player_board.place(@player_carrier, input_array)
      @player_board.render(true)
      if @battleship == true
        place_player_battleship
      else
        place_player_cruiser
      end
    else 
      p "Those are invalid coordinates. Please try again."
      place_player_carrier
    end
  end

  def place_player_battleship
  if @battleship == false
    place_player_cruiser
  end
  @cpu_placement_battleship.cpu_placement
  p "Enter the coordinates for the Battleship (3 spaces eg A1 A2 A3)"
  input = gets.chomp
  input_array = input.split(" ")
    if input = @player_board.valid_placement?(@player_battleship, input_array)
      @player_board.place(@player_battleship, input_array)
      @player_board.render(true)
      place_player_cruiser
    else 
      p "Those area invalid coordinates. Please try again."
      place_player_battleship
    end
  end
  
  def place_player_cruiser
  p "Enter coordinates for your cruiser! (3 spaces eg A1 A2 A3)"
  input = gets.chomp
  input_array = input.split(" ")
    if input = @player_board.valid_placement?(@player_cruiser, input_array)
      @player_board.place(@player_cruiser, input_array)
      @player_board.render(true)
      p "Enter the coordinates for the Submarine (2 spaces)"
      place_player_sub
    else 
      p "Those area invalid coordinates. Please try again."
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