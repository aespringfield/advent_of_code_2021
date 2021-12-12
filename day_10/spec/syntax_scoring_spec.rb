require './day_10/syntax_scoring'
# require './../day_10/syntax_scoring'

RSpec.describe 'Syntax Scoring' do
  let(:data) { File.readlines('./day_10/spec/data.txt', chomp: true) }
  # let(:data) { File.readlines('./spec/data.txt', chomp: true) }

  describe '#run' do
    it 'returns correct result for test data for part i' do
      expect(SyntaxScoring.run(data: data)).to be(26397)
    end

    it 'returns correct result for test data for part ii' do
      expect(SyntaxScoring.run(data: data, part_ii: true)).to be(288957)
    end
  end
end