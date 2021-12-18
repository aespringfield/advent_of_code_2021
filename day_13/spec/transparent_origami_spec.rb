require './day_13/transparent_origami'
# require './../day_13/transparent_origami'

RSpec.describe 'Transparent Origami' do
  let(:data) { File.readlines('./day_13/spec/data.txt', chomp: true) }
  # let(:data) { File.readlines('./spec/data.txt', chomp: true) }

  describe '#run' do
    it 'returns correct result for part i' do
      expect(TransparentOrigami.run(data: data)).to be(17)
    end
  end
end