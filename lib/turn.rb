require './lib/game'
class Turn 
  def initialize(board_1, board_2)
    @board_1 = board_1
    @board_2 = board_2
  end

  def start_turn
    p "Computer's board"
    @board_1.render
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
      @board_1.fire_upon(player_fire_upon)
      if @board_1.cells["#{player_fire_upon}"].render == "M"
        p "Your shot on #{player_fire_upon} was a miss"
      elsif @board_1.cells["#{player_fire_upon}"].render == "H"
        p "Your shot on #{player_fire_upon} was a hit!"
      elsif @board_1.cells["#{player_fire_upon}"].render == "X"
        p "Your shot on #{player_fire_upon} sunk a ship!"
      else
        p "?"
      end
    else
      p "Please enter a valid coordinate"
      player_shot
    end
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
    @board_2.fire_upon(cpu_fire_coords)
    if @board_2.cells[cpu_fire_coords].render == "M"
      p "My shot on #{cpu_fire_coords} was a miss"
    elsif @board_2.cells[cpu_fire_coords].render == "H"
      p "My shot on #{cpu_fire_coords} was a hit!"
    else @board_2.cells[cpu_fire_coords].render == "X"
      p "My shot on #{cpu_fire_coords} sunk a ship!"
    end
    start_turn
  end
end