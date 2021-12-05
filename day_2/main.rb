require './day_2/dive.rb'
require 'optparse'

class Main
  aim = false
  OptionParser.new do |opts|
    opts.on('--[no-]aim') { |opt|
      aim = opt
    }
  end.parse!
  puts Dive.run(aim: aim)
end