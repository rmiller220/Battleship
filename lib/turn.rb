
require './lib/game'
class Turn 
  attr_reader :cpu_board, 
              :player_board, 
              :cpu_sunk_ships, 
              :player_sunk_ships

  def initialize(cpu_board, player_board)
    @cpu_board = cpu_board
    @player_board = player_board
    @cpu_sunk_ships = []
    @player_sunk_ships = []
  end

  def start_turn
    p "Computer's board"
    @cpu_board.render
    p "Player board"
    @player_board.render(true)
    player_shot
  end

  def player_shot
    p "Please enter a coordinate to fire upon!"
    player_fire_upon = gets.chomp.upcase
    if @cpu_board.cells[player_fire_upon] == nil
      p "Please enter a valid coordinate"
      player_shot
    end
    if @cpu_board.cells[player_fire_upon].fired_upon? == false
      @cpu_board.cells[player_fire_upon].fire_upon
      if @cpu_board.cells[player_fire_upon].render == "M"
        p "Your shot on #{player_fire_upon} was a miss"
      elsif @cpu_board.cells[player_fire_upon].render == "H"
        p "Your shot on #{player_fire_upon} was a hit!"
      elsif @cpu_board.cells[player_fire_upon].render == "X"
        p "Your shot on #{player_fire_upon} sunk a ship!"
        @player_sunk_ships << @cpu_board.cells[player_fire_upon].ship.sunk?
        end_game_player
      else
        p "?"
      end
    else
      p "Please enter a valid coordinate"
      player_shot
    end
    p "Computer's Board"
    @cpu_board.render
    p "Player's Board"
    @player_board.render(true)
    cpu_shot
  end

  def cpu_shot
    coordinate_array = []
    ("A"..@cpu_board.row).each do |letter|
      (1..@cpu_board.column).each do |number|
        coordinate = letter + number.to_s
        coordinate_array << coordinate
      end
    end
    cpu_fire_coords = coordinate_array.sample
    cpu_fire_coords = coordinate_array.sample until @player_board.cells[cpu_fire_coords].fired_upon? == false
    @player_board.cells[cpu_fire_coords].fire_upon
    if @player_board.cells[cpu_fire_coords].render == "M"
      p "My shot on #{cpu_fire_coords} was a miss"
    elsif @player_board.cells[cpu_fire_coords].render == "H"
      p "My shot on #{cpu_fire_coords} was a hit!"
    else @player_board.cells[cpu_fire_coords].render == "X"
      p "My shot on #{cpu_fire_coords} sunk a ship!"
      end_game_cpu
    end
    start_turn
  end
  
  def end_game_cpu
    boolean_array = []
    @player_board.ship.each { |ship| boolean_array << ship.sunk? }
    if boolean_array.all?(true)
      p "Computer's Board"
      @cpu_board.render
      p "Player's Board"
      @player_board.render(true)
      puts "CPU won!"
      game = Game.new
      game.start
    else
      player_shot
    end
  end

  def end_game_player
    boolean_array = []
    @cpu_board.ship.each { |ship| boolean_array << ship.sunk? }
    if boolean_array.all?(true)
      p "Computer's Board"
      @cpu_board.render
      p "Player's Board"
      @player_board.render(true)
      puts "You won!"
      game = Game.new
      game.start
    else
      cpu_shot
    end
  end
end