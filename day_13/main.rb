require './day_13/transparent_origami.rb'
require 'optparse'

part_ii = false
OptionParser.new do |opts|
  opts.on('--[no-]part-ii') { |opt|
    part_ii = opt
  }
end.parse!

puts TransparentOrigami.run(part_ii: part_ii)