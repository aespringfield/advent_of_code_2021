require './day_4/bingo.rb'
require 'optparse'

class Main
  last = false
  OptionParser.new do |opts|
    opts.on('--[no-]last') { |opt|
      last = opt
    }
  end.parse!
  puts Bingo.run(last: last)
end