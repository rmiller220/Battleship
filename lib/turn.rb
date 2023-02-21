require './lib/game'
class Turn 
  def initialize
    
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
    if @cpu_board.cell(player_fire_upon).fired_upon? == false
      @cpu_board.cells(player_fire_upon).fire_upon
      if @cpu_board.render += "M"
        p "Your shot on #{player_fire_upon} was a miss"
      elsif @cpu_board.render += "H"
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

    if @player_board.render += "M"
      p "My shot on #{cpu_fired_shot} was a miss"
    elsif @player_board.render += "H"
      p "My shot on #{cpu_fired_shot} was a hit!"
    else 
      p "My shot on #{cpu_fired_shot} sunk a ship!"
    end
    start_turn
  end
end