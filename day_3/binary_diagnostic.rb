class BinaryDiagnostic
  def self.run(data: nil, ratings: false)
    data ||= File.readlines('./day_3/data.txt', chomp: true)
    value1, value2 = ratings ? self.find_ratings(data) : self.find_gamma_and_epsilon(data)
    self.convert_binary_to_decimal(value1) * self.convert_binary_to_decimal(value2)
  end

  def self.find_ratings(data)
    [self.find_oxygen_generator_rating(data: data), self.find_co2_scrubber_rating(data: data)]
  end

  def self.find_oxygen_generator_rating(data:)
    self.find_rating(data: data, invert: false, default_to_one: true)
  end

  def self.find_co2_scrubber_rating(data:)
    self.find_rating(data: data, invert: true, default_to_one: true)
  end

  def self.find_rating(data:, position: 0, bits_so_far: '', invert: false, default_to_one: true)
    most_common_bit = self.most_common_bit(data, position, default_to_one)
    new_bits = bits_so_far + (invert ? self.invert(most_common_bit) : most_common_bit)

    data_left = data.select { |value| value.match(/^#{new_bits}/) }
    if data_left.length > 1 && position < data[0].length
      self.find_rating(data: data_left, position: position + 1, bits_so_far: new_bits, invert: invert, default_to_one: default_to_one)
    else
      data_left.length == 0 ? data.last : data_left.first
    end
  end

  def self.find_gamma_and_epsilon(data)
    gamma = self.find_gamma(data)
    epsilon = self.invert(gamma)
    [gamma, epsilon]
  end

  def self.find_gamma(data, default_to_one: true)
    bits = []
    (0..(data[0].length - 1)).each do |i|
      bits << self.most_common_bit(data, i, default_to_one)
    end

    bits.join
  end

  def self.most_common_bit(data, position, default_to_one)
    one_count = data
      .map { |binary_number| binary_number[position] }
      .count { |bit| bit == '1' }

    zero_count = data.length - one_count
    if one_count > zero_count
      '1'
    elsif zero_count > one_count
      '0'
    else
      default_to_one ? '1' : '0'
    end
  end

  def self.invert(binary_str)
    binary_str.split('').map { |bit|  bit == '1' ? '0' : '1' }.join
  end

  def self.convert_binary_to_decimal(binary_str)
    binary_str.to_i(2)
  end
end