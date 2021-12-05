require './day_5/hydrothermal_venture.rb'
# require './../day_5/hydrothermal_venture.rb'

RSpec.describe 'Hydrothermal Venture' do
  let(:data) { File.readlines('./day_5/spec/data.txt', chomp: true) }
  # let(:data) { File.readlines('./data.txt', chomp: true) }

  describe '#run' do
    it 'returns correct result for test data' do
      expect(HydrothermalVenture.run(data: data)).to be(5)
    end

    it 'returns correct result when including diagonals' do
      expect(HydrothermalVenture.run(data: data, include_diagonal: true)).to be(12)
    end
  end

  describe '#count_overlaps' do
    it 'finds points of overlap for horizontal lines' do
      expect(HydrothermalVenture.count_overlaps([
        Line.new([[0,9],[5,9]]),
        Line.new([[0,9],[2,9]])
      ])).to eq(3)
    end
  end

  describe '#clean_data' do
    it 'returns array of line segment end coordinates' do
      expect(HydrothermalVenture.clean_data([
        "0,9 -> 5,9",
        "8,0 -> 0,8",
        "9,4 -> 3,4"
      ])).to eq([
        [[0,9],[5,9]],
        [[8,0],[0,8]],
        [[9,4],[3,4]]
      ])
    end
  end
end

RSpec.describe 'Line' do
  describe '#new' do
    it 'has the right properties' do
      line = Line.new([[0,9],[5,9]])
      expect(line.x1).to be(0)
      expect(line.y1).to be(9)
      expect(line.x2).to be(5)
      expect(line.y2).to be(9)
    end

    it 'has the right properties when coordinates listed backward' do
      line = Line.new([[5,9],[0,9]])
      expect(line.x1).to be(5)
      expect(line.y1).to be(9)
      expect(line.x2).to be(0)
      expect(line.y2).to be(9)
    end

    it 'has the right properties for vertical coordinates listed backward' do
      line = Line.new([[5,9],[5,1]])
      expect(line.x1).to be(5)
      expect(line.y1).to be(9)
      expect(line.x2).to be(5)
      expect(line.y2).to be(1)
    end
  end

  describe '#is_horizontal?' do
    it 'returns true for horizontal line' do
      line = Line.new([[0,9],[5,9]])
      expect(line.is_horizontal?).to be(true)
    end

    it 'returns false for not horizontal line' do
      line = Line.new([[0,0],[0,9]])
      expect(line.is_horizontal?).to be(false)
    end
  end

  describe '#is_vertical?' do
    it 'returns true for vertical line' do
      line = Line.new([[9,0],[9,9]])
      expect(line.is_vertical?).to be(true)
    end

    it 'returns false for not vertical line' do
      line = Line.new([[0,9],[5,9]])
      expect(line.is_vertical?).to be(false)
    end
  end

  # describe '#overlaps_with' do
  #   it 'returns overlaps if line overlaps horizontally' do
  #     line1 = Line.new([[0,9],[5,9]])
  #     line2 = Line.new([[6,9],[2,9]])
  #     expect(line1.overlaps_with(line2)).to eq([
  #       [2,9],
  #       [3,9],
  #       [4,9],
  #       [5,9]
  #     ])
  #   end
  #
  #   it 'returns overlaps if line overlaps vertically' do
  #     line1 = Line.new([[2,1],[2,5]])
  #     line2 = Line.new([[2,6],[2,2]])
  #     expect(line1.overlaps_with(line2)).to eq([
  #       [2,2],
  #       [2,3],
  #       [2,4],
  #       [2,5]
  #     ])
  #   end
  #
  #   it 'returns overlaps if line intersects' do
  #     line1 = Line.new([[5,8],[0,8]])
  #     line2 = Line.new([[3,9],[3,2]])
  #     expect(line1.overlaps_with(line2)).to eq([
  #       [3,8]
  #     ])
  #   end
  # end

  describe '#integer_points_covered' do
    it 'returns points for a horizontal line' do
      expect(Line.new([[0, 5], [4,5]]).integer_points_covered).to eq([
        [0,5],
        [1,5],
        [2,5],
        [3,5],
        [4,5]
      ])
    end

    it 'returns points for a horizontal line with the coordinates listed backward' do
      expect(Line.new([[5, 0], [3,0]]).integer_points_covered).to eq([
        [3,0],
        [4,0],
        [5,0]
      ])
    end

    it 'returns points for a vertical line with the coordinates listed backward' do
      expect(Line.new([[5, 0], [3,0]]).integer_points_covered).to eq([
        [3,0],
        [4,0],
        [5,0]
      ])
    end

    it 'returns points for a diagonal line' do
      expect(Line.new([[5,10], [8,25]]).integer_points_covered).to eq([
        [5,10],
        [6,15],
        [7,20],
        [8,25]
      ])
    end

    it 'returns points for a diagonal line listed backwards' do
      expect(Line.new([[8,25], [5,10]]).integer_points_covered).to eq([
        [5,10],
        [6,15],
        [7,20],
        [8,25]
      ])
    end

    it 'returns points for a diagonal line with some non-integer points' do
      expect(Line.new([[5,10], [9, 20]]).integer_points_covered).to eq([
        [5,10],
        [7,15],
        [9,20]
      ])
    end
  end

  describe '#slope' do
    it "returns nil if line is vertical" do
      expect(Line.new([[5, 3], [5,1]]).slope).to eq(nil)
    end

    it "returns slope of horizontal line" do
      expect(Line.new([[4, 3], [5,3]]).slope).to eq(0)
    end

    it "returns slope of diagonal line" do
      expect(Line.new([[4, 3], [5, 9]]).slope).to eq(6.0)
    end
  end
end