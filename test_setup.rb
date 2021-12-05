root, day, name = __FILE__.match(/(.*advent_of_code_2021).*day_(\d).*spec\/(.*)_spec/).captures

$LOAD_PATH << File.join('.', "day_#{day}")
$LOAD_PATH << File.join('.', "day_#{day}", 'spec')

require "#{root}/#{name}.rb"
# $LOAD_PATH << File.expand_path(Dir.pwd)
# $LOAD_PATH << File.join File.basename(__FILE__).match(/^(.*)_spec/).captures.first
