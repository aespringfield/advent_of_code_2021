class TransparentOrigami
  def self.run(data: File.readlines('./day_13/data.txt', chomp: true), part_ii: false)
    dot_coordinates, fold_instructions = clean(data)
    if part_ii
      new_coordinates = fold(dot_coordinates, fold_instructions)
      max_x = new_coordinates.max_by { |(x, _)| x }[0]
      max_y = new_coordinates.max_by { |(_, y)| y }[1]
      empty_grid = Array.new(max_y + 1) { Array.new(max_x + 1) { '.' } }
      new_coordinates
        .each_with_object(empty_grid) { |(x, y), memo| memo[y][x] = '#' }
        .map { |row| row.join }.join("\n")
    else
      fold(dot_coordinates, fold_instructions.slice(0, 1)).count
    end
  end

  def self.fold(dot_coordinates, fold_instructions)
    return dot_coordinates if fold_instructions.empty?

    axis, line_position = fold_instructions.first
    coord_index = axis == 'x' ? 0 : 1
    other_index = coord_index == 0 ? 1 : 0
    prefold, postfold = dot_coordinates.partition { |dot_coordinate| dot_coordinate[coord_index] < line_position }
    postfold.each do |dot_coordinate|
      new_coordinate = []
      new_coordinate[coord_index] = line_position*2 - dot_coordinate[coord_index]
      new_coordinate[other_index] = dot_coordinate[other_index]
      prefold << new_coordinate
    end

    fold(prefold.uniq, fold_instructions.slice(1, fold_instructions.length))
  end

  def self.clean(data)
    i = data.find_index { |line| line.empty? }
    [
      data.slice(0, i).map { |coord_str| coord_str.split(',').map(&:to_i) },
      data.slice(i+1, data.length)
        .map { |instruction| instruction.match(/^fold along (\w)=(\d+)$/).captures }
        .map { |(axis, line_position)| [axis, line_position.to_i] }
    ]
  end
end