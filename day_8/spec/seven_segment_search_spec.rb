require './day_8/seven_segment_search.rb'
# require './../day_8/seven_segment_search.rb'

RSpec.describe 'Seven Segment Search' do
  let(:data) { File.readlines('./day_8/spec/data.txt', chomp: true) }
  # let(:data) { File.readlines('./data.txt', chomp: true) }

  describe '#run' do
    it 'returns correct result for test data when counting easy digits' do
      expect(SevenSegmentSearch.run(data: data)).to be(26)
    end

    it 'returns correct result for test data when adding all digits' do
      expect(SevenSegmentSearch.run(data: data, add_all: true)).to be(61229)
    end
  end
end