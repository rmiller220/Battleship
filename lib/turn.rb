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
    if @board_1.fire_upon(player_fire_upon) == true
      @board_1.fire_upon(player_fire_upon)
      if @board_1.render == "M"
        p "Your shot on #{player_fire_upon} was a miss"
      elsif @board_1.render == "H"
        p "Your shot on #{player_fire_upon} was a hit!"
      else 
        p "Your shot on #{player_fire_upon} sunk a ship!"
      end
    else
      p "Please enter a valid coordinate"
      player_shot
    end
  end

  def cpu_shot
    coordinate_array = []
    ("A".."D").each do |letter|
      (1..4).each do |number|
        coordinate = letter + number.to_s
        coordinate_array << coordinate
      end
    end
    cpu_fired_shot = coordinate_array.sample.fire_upon
    coordinate_array.sample.fire_upon until fire_upon(coordinate_array.sample) != false
    cpu_fired_shot = coordinate_array.sample.fire_upon

    if @board_2.render += "M"
      p "My shot on #{cpu_fired_shot} was a miss"
    elsif @board_2.render += "H"
      p "My shot on #{cpu_fired_shot} was a hit!"
    else 
      p "My shot on #{cpu_fired_shot} sunk a ship!"
    end
    start_turn
  end
end