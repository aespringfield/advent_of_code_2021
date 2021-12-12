require './day_8/seven_segment_search.rb'
require 'optparse'

add_all = false
OptionParser.new do |opts|
  opts.on('--[no-]add-all-outputs') { |opt|
    add_all = opt
  }
end.parse!

puts SevenSegmentSearch.run(add_all: add_all)