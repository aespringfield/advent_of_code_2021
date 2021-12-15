require './day_11/dumbo_octopus'
# require './../day_11/dumbo_octopus'

RSpec.describe 'Dumbo Octopus' do
  let(:data) { File.readlines('./day_11/spec/data.txt', chomp: true) }
  # let(:data) { File.readlines('./spec/data.txt', chomp: true) }

  describe '#run' do
    it 'returns correct result for test data for part i' do
      expect(DumboOctopus.run(data: data)).to be(1656)
    end

    it 'returns correct result for test data for part ii' do
      expect(DumboOctopus.run(data: data, part_ii: true)).to be(195)
    end
  end
end