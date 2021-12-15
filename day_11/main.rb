require './day_11/dumbo_octopus.rb'
require 'optparse'

part_ii = false
OptionParser.new do |opts|
  opts.on('--[no-]part-ii') { |opt|
    part_ii = opt
  }
end.parse!

puts DumboOctopus.run(part_ii: part_ii)