class HydrothermalVenture
  def self.run(data: File.readlines('./day_5/data.txt', chomp: true), include_diagonal: false)
    lines = self.clean_data(data).map { |coordinates_pair| Line.new(coordinates_pair) }
    lines_to_consider = include_diagonal ? lines : lines.select { |line| line.is_horizontal? || line.is_vertical? }
    self.find_overlaps(lines_to_consider).count
  end

  def self.find_overlaps(lines, overlaps: [])
    first_line, *rest_of_lines = lines

    new_overlap_sets = rest_of_lines.filter_map do |line|
      overlaps_for_line_pair = first_line.integer_points_covered.intersection(line.integer_points_covered)
      !overlaps_for_line_pair.empty? && overlaps_for_line_pair
    end

    rest_of_lines.empty? ? overlaps.uniq : self.find_overlaps(rest_of_lines, overlaps: overlaps + new_overlap_sets.flatten(1))
  end

  def self.clean_data(data)
    data.map do |line|
      line.split('->').map do |coordinate_pair|
        coordinate_pair.split(',').map { |num_str| num_str.strip.to_i }
      end
    end
  end
end

class Line
  attr_reader :x1, :x2, :y1, :y2, :coordinates_pair

  def initialize(coordinates_pair)
    @coordinates_pair = coordinates_pair
    @x1 = coordinates_pair[0][0]
    @x2 = coordinates_pair[1][0]
    @y1 = coordinates_pair[0][1]
    @y2 = coordinates_pair[1][1]
  end

  def is_horizontal?
    @y1 == @y2
  end

  def is_vertical?
    @x1 == @x2
  end

  def integer_points_covered
    return @integer_points if @integer_points

    first_x, first_y = @coordinates_pair.min
    second_x, second_y = @coordinates_pair.max

    integer_points = []
    x_range = second_x - first_x
    if x_range > 0
      (0..x_range).each do |x_modifier|
        x = first_x + x_modifier
        y = slope * (x - second_x) + second_y
        integer_points << [x.to_i, y.to_i] if is_integer_point?([x, y])
      end
    else
      y_range = second_y - first_y
      integer_points = (0..y_range).map do |y_modifier|
        [first_x, first_y + y_modifier]
      end
    end

    @integer_points = integer_points
  end

  def slope
    return if is_vertical?
    (@y2 - @y1).to_f/(@x2 - @x1).to_f
  end

  private

  def is_integer_point?(coordinates)
    coordinates[0] - coordinates[0].round == 0 && coordinates[1] - coordinates[1].round == 0
  end
end
