require './day_12/passage_pathing'
# require './../day_12/passage_pathing'

RSpec.describe 'Passage Pathing' do
  let(:data) { File.readlines('./day_12/spec/data.txt', chomp: true) }
  # let(:data) { File.readlines('./spec/data.txt', chomp: true) }

  describe '#run' do
    it 'returns correct result for smaller test data set for part i' do
      data = File.readlines('./day_12/spec/smaller_data.txt', chomp: true)
      # data = File.readlines('./spec/smaller_data.txt', chomp: true)
      expect(PassagePathing.run(data: data)).to be(10)
    end

    it 'returns correct result for test data for part i' do
      expect(PassagePathing.run(data: data)).to be(19)
    end

    it 'returns correct result for maller test data for part ii' do
      data = File.readlines('./day_12/spec/smaller_data.txt', chomp: true)
      # data = File.readlines('./spec/smaller_data.txt', chomp: true)
      expect(PassagePathing.run(data: data, part_ii: true)).to be(36)
    end

    it 'returns correct result for test data for part ii' do
      expect(PassagePathing.run(data: data, part_ii: true)).to be(103)
    end
  end
end