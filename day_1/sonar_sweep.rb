class SonarSweep
  def self.run(window_length)
    data = File.readlines('./day_1/data.txt').map(&:to_i)
    puts self.count_increases(data, window_length: window_length.to_i)
  end

  def self.count_increases(data, window_length: 1)
    data.each.with_index.reduce(0) do |increases, (_, i)|
      return increases if window_length > (data.length - i - 1)
      first_arr = data.slice(i, window_length)
      second_arr =data.slice(i + 1, window_length)

      second_arr.sum > first_arr.sum ? increases + 1 : increases
    end
  end
end