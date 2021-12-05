class Dive
  def self.run(aim: false)
    data = File.readlines('./day_2/data.txt')
    horizontal_position, depth = self.track_movement(data, aim: aim)
    horizontal_position * depth
  end

  def self.track_movement(instructions, aim: false)
    results = instructions.reduce({ horizontal_position: 0, depth: 0, aim: 0 }) do |memo, instruction|
      direction, magnitude = instruction.match(/(\w+) (\d+)/).captures
      case direction
      when 'forward'
        memo[:horizontal_position] = memo[:horizontal_position] + magnitude.to_i
        if aim
          memo[:depth] = memo[:depth] + memo[:aim] * magnitude.to_i
        end
      when 'up'
        if aim
          memo[:aim] = memo[:aim] - magnitude.to_i
        else
          memo[:depth] = memo[:depth] - magnitude.to_i
        end
      when 'down'
        if aim
          memo[:aim] = memo[:aim] + magnitude.to_i
        else
          memo[:depth] = memo[:depth] + magnitude.to_i
        end
      end
      memo
    end

    [results[:horizontal_position], results[:depth]]
  end
end