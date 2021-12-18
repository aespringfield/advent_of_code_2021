require './day_12/passage_pathing.rb'
require 'optparse'

part_ii = false
OptionParser.new do |opts|
  opts.on('--[no-]part-ii') { |opt|
    part_ii = opt
  }
end.parse!

puts PassagePathing.run(part_ii: part_ii)