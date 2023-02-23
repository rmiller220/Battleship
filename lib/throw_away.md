 Throw away code for later. This was an attempted refactor of the cpu_placement method. 
 The method "breaks" with ships of lengths 4 and 5 due to the vast amount of possible combinations.
 4 length ships take 30 seconds - 1 minute to load and 5 length ships take around 10 minutes.
 
 # @coordinate = coordinate_array.sample
    # @coordinates = coordinate_array[coordinate_array.index(@coordinate)..coordinate_array.index(@coordinate) + @ship.length]
    # until board.valid_placement?(@ship, @coordinates) == true
    #   @coordinate = coordinate_array.sample
    #   @coordinates = coordinate_array[coordinate_array.index(@coordinate)..coordinate_array.index(@coordinate) + @ship.length]
    #   split = @coordinate.split("")
    #   @horizontal_coordinates
    #   horizontal = []
    #   horizontal << split.first.ord
    #   horizontal_coords = [*horizontal.first..ship.length]
    #   horizontal_coords.each do |num|
    #     horizontal_coordinate = num.chr + split.last.to_s
    #     @horizontal_coordinates << horizontal_coordinate
    #   end
    # end
    # board.valid_placement?(@ship, @coordinates)
    # board.place(@ship, @coordinates)