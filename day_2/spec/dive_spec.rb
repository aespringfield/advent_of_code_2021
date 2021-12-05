require './day_2/dive'

RSpec.describe 'Dive' do
  let(:data) { File.readlines('./day_2/spec/data.txt') }

  describe '#track_movement' do
    describe 'without aim' do
      it 'goes nowhere when there is no movement' do
        expect(Dive.track_movement([])).to eq([0, 0])
      end

      it 'moves forward' do
        expect(Dive.track_movement(['forward 3'])).to eq([3, 0])
      end

      it 'moves forward multiple times' do
        expect(Dive.track_movement(['forward 3', 'forward 4'])).to eq([7, 0])
      end

      it 'moves forward and down' do
        expect(Dive.track_movement(['forward 3', 'down 3', 'forward 4', 'down 2'])).to eq([7, 5])
      end

      it 'moves all over the place' do
        expect(Dive.track_movement(data)).to eq([15, 10])
      end
    end

    describe 'with aim' do
      it 'goes nowhere when there is no movement' do
        expect(Dive.track_movement([])).to eq([0, 0])
      end

      it 'moves forward' do
        expect(Dive.track_movement(['forward 3'], aim: true)).to eq([3, 0])
      end

      it 'moves forward multiple times' do
        expect(Dive.track_movement(['forward 3', 'forward 4'], aim: true)).to eq([7, 0])
      end

      it 'moves forward and down' do
        expect(Dive.track_movement(['forward 3', 'down 3', 'forward 4', 'down 2'], aim: true)).to eq([7, 12])
      end

      it 'moves all over the place' do
        expect(Dive.track_movement(data, aim: true)).to eq([15, 60])
      end
    end
  end
end