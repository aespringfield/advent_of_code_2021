require './day_7/whale_treachery.rb'
require 'optparse'

triangular = false
OptionParser.new do |opts|
  opts.on('--[no-]triangular') { |opt|
    triangular = opt
  }
end.parse!

puts WhaleTreachery.run(triangular: triangular)