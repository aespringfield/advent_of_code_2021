require './day_9/smoke_basin.rb'
require 'optparse'

basins = false
OptionParser.new do |opts|
  opts.on('--[no-]basins') { |opt|
    basins = opt
  }
end.parse!

puts SmokeBasin.run(basins: basins)