require './day_7/whale_treachery.rb'

class SyntaxScoring
  SYNTAX_ERROR_SCORES = {
    ')' => 3,
    ']' => 57,
    '}' => 1197,
    '>' => 25137
  }

  AUTOCOMPLETE_SCORES = {
    ')' => 1,
    ']' => 2,
    '}' => 3,
    '>' => 4
  }

  CHARACTER_PAIRS = {
    '(' => ')',
    '[' => ']',
    '{' => '}',
    '<' => '>'
  }

  def self.run(data: File.readlines('./day_10/data.txt', chomp: true), part_ii: false)
    results = data
      .filter_map { |line| find_first_syntax_error(line, ignore_incomplete: !part_ii) }

    if part_ii
      WhaleTreachery.find_median(
        results.map do |closing_chars|
          closing_chars.reduce(0) do |memo, char|
            memo * 5 + AUTOCOMPLETE_SCORES[char]
          end
        end,
        presorted: false
      )
    else
      results
        .map { |syntax_error| score_syntax_error(syntax_error) }
        .sum
    end
  end

  def self.find_first_syntax_error(line, ignore_incomplete: true)
    opening_chars = CHARACTER_PAIRS.keys

    opening_chars_left, bad_char = line.chars.each_with_object([[]]) do |char, memo|
      if opening_chars.include?(char)
        memo[0] << char
      else
        last_char = memo[0].pop
        if CHARACTER_PAIRS[last_char] != char
          memo[1] = char
          break memo
        end
      end
    end

    if ignore_incomplete
      bad_char
    else
      !bad_char && opening_chars_left.reverse.map { |char| CHARACTER_PAIRS[char] }
    end
  end

  def self.score_syntax_error(syntax_error)
    SYNTAX_ERROR_SCORES[syntax_error]
  end
end