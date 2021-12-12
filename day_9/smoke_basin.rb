class SmokeBasin
  def self.run(data: File.readlines('./day_9/data.txt', chomp: true), basins: false)
    rows = data.map { |row| row.chars.map(&:to_i) }
    @@points_explored = Array.new(rows.length) { Array.new(rows.first.length) { '-' } }
    if basins
      basins = find_basins(rows)
      new_rows = rows.map { |row| row.dup }
      vis = new_rows.map { |r| r.join(' ')}.join("\n")
      puts vis
      basins.each { |basin| basin.each { |row_i, col_i| new_rows[row_i][col_i] = 'x' } }
      multiply_size_of_three_largest_basins(basins)
    else
      low_points = find_low_points(rows)
      sum_risk_levels(low_points)
    end
  end

  def self.multiply_size_of_three_largest_basins(basins)
    basins.max(3) { |a, b| a.count <=> b.count }.map(&:count).reduce(&:*)
  end

  def self.find_basins(rows)
    low_points = find_low_points(rows)
    low_points.map do |_, low_point_coords|
      find_basin_from_point(low_point_coords, rows, [low_point_coords]).sort
    end.uniq
  end

  def self.map_points_explored(coords)
    puts '***********************'
    row_i, col_i = coords
    @@points_explored[row_i][col_i] = 'x'
    vis_map = @@points_explored.map(&:join).join("\n")
    puts vis_map
  end

  def self.find_basin_from_point(coords, rows, basin_points)
    up_loc_value, up_loc_coords = up_location(*coords, rows)
    if is_new_part_of_basin?(up_loc_value, up_loc_coords, rows, basin_points)
      basin_points = find_basin_from_point(up_loc_coords, rows, [*basin_points, up_loc_coords])
    end

    down_loc_value, down_loc_coords = down_location(*coords, rows)
    if is_new_part_of_basin?(down_loc_value, down_loc_coords, rows, basin_points)
      basin_points = find_basin_from_point(down_loc_coords, rows, [*basin_points, down_loc_coords])
    end

    left_loc_value, left_loc_coords = left_location(*coords, rows)
    if is_new_part_of_basin?(left_loc_value, left_loc_coords, rows, basin_points)
      basin_points = find_basin_from_point(left_loc_coords, rows, [*basin_points, left_loc_coords])
    end

    right_loc_value, right_loc_coords = right_location(*coords, rows)
    if is_new_part_of_basin?(right_loc_value, right_loc_coords, rows, basin_points)
      basin_points = find_basin_from_point(right_loc_coords, rows, [*basin_points, right_loc_coords])
    end

    basin_points
  end

  def self.is_new_part_of_basin?(value, coords, rows, basin_points)
    return false if value == 9 || basin_points.include?(coords)

    up_loc_value, up_loc_coords = up_location(*coords, rows)
    return false unless value < up_loc_value || basin_points.include?(up_loc_coords)

    down_loc_value, down_loc_coords = down_location(*coords, rows)
    return false unless value < down_loc_value || basin_points.include?(down_loc_coords)

    left_loc_value, left_loc_coords = left_location(*coords, rows)
    return false unless value < left_loc_value || basin_points.include?(left_loc_coords)

    right_loc_value, right_loc_coords = right_location(*coords, rows)
    return false unless value < right_loc_value || basin_points.include?(right_loc_coords)

    map_points_explored(coords)

    true
  end

  def self.sum_risk_levels(low_points)
    low_points.reduce(0) { |memo, (low_point_value, _)| memo + low_point_value + 1 }
  end

  def self.find_low_points(rows)
    rows.each_with_object([]).with_index do |(row, memo), row_i|
      row.each_with_index do |value, col_i|
        up_loc_value, _ = up_location(row_i, col_i, rows)
        down_loc_value, _ = down_location(row_i, col_i, rows)
        left_loc_value, _ = left_location(row_i, col_i, rows)
        right_loc_value, _ = right_location(row_i, col_i, rows)
        if value < up_loc_value && value < down_loc_value && value < left_loc_value && value < right_loc_value
          memo << [value, [row_i, col_i]]
        end
      end
    end
  end

  def self.is_in_bounds?(row_i, col_i, rows)
    row_i >= 0 && row_i < rows.length && col_i >= 0 && col_i < rows[row_i].length
  end

  def self.up_location(row_i, col_i, rows)
    loc_row_i = row_i - 1
    loc_value = is_in_bounds?(loc_row_i, col_i, rows) ? rows[loc_row_i][col_i] : Float::INFINITY
    [loc_value, [loc_row_i, col_i]]
  end

  def self.down_location(row_i, col_i, rows)
    loc_row_i = row_i + 1
    loc_value = is_in_bounds?(loc_row_i, col_i, rows) ? rows[loc_row_i][col_i] : Float::INFINITY
    [loc_value, [loc_row_i, col_i]]
  end

  def self.left_location(row_i, col_i, rows)
    loc_col_i = col_i - 1
    loc_value = is_in_bounds?(row_i, loc_col_i, rows) ? rows[row_i][loc_col_i] : Float::INFINITY
    [loc_value, [row_i, loc_col_i]]
  end

  def self.right_location(row_i, col_i, rows)
    loc_col_i = col_i + 1
    loc_value = is_in_bounds?(row_i, loc_col_i, rows) ? rows[row_i][loc_col_i] : Float::INFINITY
    [loc_value, [row_i, loc_col_i]]
  end
end