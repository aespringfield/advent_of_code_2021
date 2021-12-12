require './day_10/syntax_scoring'
require 'optparse'

part_ii = false
OptionParser.new do |opts|
  opts.on('--[no-]part-ii') { |opt|
    part_ii = opt
  }
end.parse!

puts SyntaxScoring.run(part_ii: part_ii)