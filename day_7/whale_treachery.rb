class WhaleTreachery
  def self.run(triangular: false)
    data = File.read('./day_7/data.txt', chomp: true)
    crab_positions = data.split(',').map(&:to_i).sort

    _, movement = if triangular
                           avg = self.find_median(crab_positions)
                           self.find_minimum_movement_position(avg, (crab_positions.length / 4.0).round, crab_positions) do |position, positions|
                             self.calculate_triangular_movement(position, positions)
                           end
                         else
                           median = self.find_median(crab_positions)
                           self.find_minimum_movement_position(median, (crab_positions.length / 4.0).round, crab_positions)
                         end

    movement
  end

  def self.find_minimum_movement_position(start_position, interval, positions, start_position_movement=nil, run_count=0, &block)
    block ||= block_given? ? block : method(:calculate_movement)

    lower_position = start_position - interval
    higher_position = start_position + interval
    
    results = {}
    results[start_position] = start_position_movement || block.call(start_position, positions)
    results[lower_position] = block.call(lower_position, positions)
    results[higher_position] = block.call(higher_position, positions)

    best_position, best_position_movement = results.min { |(_, v1), (_, v2)| v1 <=> v2 }

    return [best_position, best_position_movement] if higher_position - lower_position <= 2

    # if start position movement is best: keep same start position and divide interval in half
    if start_position == best_position
      self.find_minimum_movement_position(start_position, (interval / 2.0).ceil, positions, start_position_movement, run_count + 1, &block)
    else
      # if one of the others is better: use that as new start position & keep same interval, run again
      self.find_minimum_movement_position(best_position, interval, positions, best_position_movement, run_count + 1, &block)
    end
  end

  def self.calculate_movement(position, positions)
    positions.reduce(0) { |total, pos| total + (position - pos).abs }
  end

  def self.calculate_triangular_movement(position, positions)
    positions.reduce(0) do |total, pos|
      distance = (position - pos).abs
      total + (distance * (distance + 1) / 2)
    end
  end

  def self.find_average(arr)
    (arr.sum.to_f / arr.length).round
  end

  def self.find_median(arr, presorted: true)
    arr = presorted ? arr : arr.sort
    arr.length.odd? ? arr[(arr.length / 2).floor] : ((arr[arr.length / 2] + arr[(arr.length / 2) - 1 ]) / 2.0).round
  end
end