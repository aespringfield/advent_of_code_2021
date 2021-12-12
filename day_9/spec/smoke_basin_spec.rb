# require './day_9/smoke_basin.rb'
require './../day_9/smoke_basin.rb'

RSpec.describe 'Smoke Basin' do
  # let(:data) { File.readlines('./day_9/spec/data.txt', chomp: true) }
  let(:data) { File.readlines('./spec/data.txt', chomp: true) }

  describe '#run' do
    it 'returns correct result for low points' do
      expect(SmokeBasin.run(data: data)).to be(15)
    end

    it 'returns correct result for basins' do
      expect(SmokeBasin.run(data: data, basins: true)).to be(1134)
    end
  end
end