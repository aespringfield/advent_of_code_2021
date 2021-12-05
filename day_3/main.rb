require './day_3/binary_diagnostic.rb'
require 'optparse'

class Main
  ratings = false
  OptionParser.new do |opts|
    opts.on('--[no-]ratings') { |opt|
      ratings = opt
    }
  end.parse!
  puts BinaryDiagnostic.run(ratings: ratings)
end