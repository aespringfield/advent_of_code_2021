require './day_1/sonar_sweep.rb'

RSpec.describe 'SonarSweep' do
  let(:data) { File.readlines('./day_1/spec/data.txt').map(&:to_i) }

  describe '#count_increases' do
    it 'counts increases' do
      expect(SonarSweep.count_increases(data)).to be(7)
    end

    it 'counts increases for a rolling window' do
      expect(SonarSweep.count_increases(data, window_length: 3)).to be(5)
    end

    it 'counts increases when data is short and there are no increases' do
      expect(SonarSweep.count_increases([6, 3, 2, 1], window_length: 3)).to be(0)
    end

    it 'counts increases when data is short and there is an increase' do
      expect(SonarSweep.count_increases([0, 3, 2, 6], window_length: 3)).to be(1)
    end
  end
end
