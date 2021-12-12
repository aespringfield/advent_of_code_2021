class SevenSegmentSearch
  POSSIBLE_SEGMENTS = %w[a b c d e f g]

  def self.run(data: File.readlines('./day_8/data.txt', chomp: true), add_all: false)
    displays = data.map do |line|
      inputs, outputs = line.split('|').map { |str| str.split(' ') }
      { inputs: inputs, outputs: outputs }
    end

    if add_all
      add_all_digits(displays)
    else
      count_easy_digits_for(displays.flat_map { |display| display[:outputs] })
    end
  end

  def self.add_all_digits(displays)
    displays.reduce(0) { |memo, display| memo + decode_display(display).join.to_i }
  end

  def self.count_easy_digits_for(signals)
    signals.select { |signal| unique_digit_for(signal) }.count
  end

  def self.decode_display(display)
    # alphabetize each input and output
    sorted_display = display.transform_values { |v| v.map(&:chars).map { |segments| segments.sort.join } }
    inputs = sorted_display[:inputs]
    outputs = sorted_display[:outputs]

    decoded_digits = inputs.each_with_object({}) do |input, memo|
      unique_digit = unique_digit_for(input)
      if unique_digit
        memo[unique_digit] = input
      end
    end

    a = (decoded_digits[7].chars - decoded_digits[1].chars).first
    # compare 1 & 4: two segments 4 has that 1 doesn't are each either b or d
    bd = (decoded_digits[4].chars - decoded_digits[1].chars) - [a]

    # find the 5-segment digits. They all share only a, d, and g.
    five_segment_digits = inputs.select { |input| input.length == 5 }
    dg = five_segment_digits.map(&:chars).reduce { |intersection, digit| intersection & digit } - [a]

    # find the intersection of the above two sets of segments to get d. Then you can get b and g.
    d = (dg & bd).first
    b = (bd - [d]).first
    g = (dg - [d]).first

    # the one letter we haven't seen so far is e
    e = (POSSIBLE_SEGMENTS - [a, b, *decoded_digits[1].chars, d, g]).first

    # decode 0
    decoded_digits[0] = [a, b, *decoded_digits[1].chars, e, g].sort.join
    # decode 3
    decoded_digits[3] = [a, *decoded_digits[1].chars, d, g].sort.join
    # decode 9
    decoded_digits[9] = [a, b, *decoded_digits[1].chars, d, g].sort.join
    # 2 is the 5-segment digit that has e in it
    decoded_digits[2] = five_segment_digits.find { |digit| digit.chars.include?(e) }
    # 5 is the 5-segment digit that doesn't match anything previously decoded
    decoded_digits[5] = five_segment_digits.find { |digit| !decoded_digits.values.include?(digit) }
    # 6 is the 6-segment digit that doesn't match anything previously decoded
    decoded_digits[6] = inputs.select { |input| input.length == 6 }.find { |digit| !decoded_digits.values.include?(digit) }

    # go through outputs and decode
    outputs.map { |output| decoded_digits.find { |_, v| v == output }.first }
  end

  def self.update_decoded_outputs(undecoded_outputs:, decoded_outputs:, decoded_digit:)
    undecoded_outputs.each_with_object({
      decoded_outputs: decoded_outputs.dup,
      undecoded_outputs: []
    }) do |undecoded_output, memo|
      if decoded_digit[:segments] == undecoded_output[:segments]
        memo[:decoded_outputs][undecoded_output[:original_index]] == decoded_digit[:value]
      else
        memo[:undecoded_outputs] << undecoded_output
      end
    end
  end

  def self.unique_digit_for(str)
    case str.length
    when 2
      1
    when 4
      4
    when 3
      7
    when 7
      8
    else
      nil
    end
  end
end