require './lib/grid_of_stuff.rb'

class DumboOctopus
  def self.run(data: File.readlines('./day_11/data.txt', chomp: true), part_ii: false)
    rows = data.map { |line| line.chars.map(&:to_i) }

    if part_ii
      find_first_synch_flash(GridOfStuff.new(rows))
    else
      count_all_flashes(rows)
    end
  end

  def self.find_first_synch_flash(grid, step_count=0)
    return step_count if grid.rows.count { |row| row.find { |value| value != 0 } } == 0

    run_step(grid)
    find_first_synch_flash(grid, step_count + 1)
  end

  def self.count_all_flashes(rows)
    grid = GridOfStuff.new(rows)

    (1..100).sum do
      run_step(grid).reduce(0) { |memo, (_, v)| memo + v.keys.count }
    end
  end

  def self.run_step(grid)
    grid.recursively_find_all(
      diagonal: true,
      transformation: -> (v, _) { v + 1 },
      transformation_if_true: ->(_, _) { 0 },
      transformation_if_false: ->(v, _) { v + 1 }
    ) { |v, _| v > 9 }
  end
end