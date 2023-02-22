require './lib/game'
class Turn 
  def initialize(board_1, board_2)
    @board_1 = board_1
    @board_2 = board_2
    @cpu_sunk_ships = []
    @player_sunk_ships = []
  end

  def start_turn
    p "Computer's board"
    @board_1.render(true)
    p "Player board"
    @board_2.render(true)
    player_shot
  end

  def player_shot
    p "Please enter a coordinate to fire upon!"
    player_fire_upon = gets.chomp.upcase
    if @board_1.cells[player_fire_upon] == nil
      p "Please enter a valid coordinate"
      player_shot
    end
    if @board_1.cells[player_fire_upon].fired_upon? == false
      # require 'pry'; binding.pry
      @board_1.cells[player_fire_upon].fire_upon
      if @board_1.cells[player_fire_upon].render == "M"
        p "Your shot on #{player_fire_upon} was a miss"
      elsif @board_1.cells[player_fire_upon].render == "H"
        p "Your shot on #{player_fire_upon} was a hit!"
      elsif @board_1.cells[player_fire_upon].render == "X"
        p "Your shot on #{player_fire_upon} sunk a ship!"
        @player_sunk_ships << @board_1.cells[player_fire_upon].ship.sunk?
        end_game_player
      else
        p "?"
      end
    elsif @board_1.cells[player_fire_upon].fired_upon? 
        p "Oops, you already fired on that spot!"
        player_shot
    else
      p "Please enter a valid coordinate"
      player_shot
    end
    @board_1.render(true)
    @board_2.render(true)
    cpu_shot
  end

  def cpu_shot
    coordinate_array = []
    ("A".."D").each do |letter|
      (1..4).each do |number|
        coordinate = letter + number.to_s
        coordinate_array << coordinate
      end
    end
    cpu_fire_coords = coordinate_array.sample
    cpu_fire_coords = coordinate_array.sample until @board_2.cells[cpu_fire_coords].fired_upon? == false
    @board_2.cells[cpu_fire_coords].fire_upon
    if @board_2.cells[cpu_fire_coords].render == "M"
      p "My shot on #{cpu_fire_coords} was a miss"
    elsif @board_2.cells[cpu_fire_coords].render == "H"
      p "My shot on #{cpu_fire_coords} was a hit!"
    else @board_2.cells[cpu_fire_coords].render == "X"
      p "My shot on #{cpu_fire_coords} sunk a ship!"
      @cpu_sunk_ships << @board_2.cells[cpu_fire_coords].ship.sunk?
       end_game_cpu
    end
    start_turn
  end
  def end_game_cpu
    if @cpu_sunk_ships.size == 2
      puts "I won!"
      game = Game.new
      game.start
    else
      player_shot
    end
  end
  def end_game_player
    if @player_sunk_ships.size == 2
      puts "You won!"
      game = Game.new
      game.start
    else
      cpu_shot
    end
  end
end