require './day_5/hydrothermal_venture.rb'
require 'optparse'

diagonal = false
OptionParser.new do |opts|
  opts.on('--[no-]include-diagonal') { |opt|
    diagonal = opt
  }
end.parse!

puts HydrothermalVenture.run(include_diagonal: diagonal)