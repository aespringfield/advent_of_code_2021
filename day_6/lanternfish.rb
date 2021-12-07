class Lanternfish
  def self.run
    data = File.read('./day_6/data.txt', chomp: true)
    fish_days_left_counts = data.split(',').map(&:to_i).sort.tally
    new_fish_days_left_counts = simulate_days(256, fish_days_left_counts)
    new_fish_days_left_counts.values.sum
  end

  def self.simulate_days(days_left, fish_days_left_counts)
    return fish_days_left_counts if days_left == 0

    new_fish_days_left_counts = fish_days_left_counts.each_with_object({}) do |(fish_days_left, fish_count), memo|
      if fish_days_left == 0
        memo[6] = (memo[6] || 0) + fish_count
        memo[8] = fish_count
      else
        memo[fish_days_left - 1] = (memo[fish_days_left - 1] || 0) + fish_count
      end
    end

    simulate_days(days_left - 1, new_fish_days_left_counts)
  end
end
