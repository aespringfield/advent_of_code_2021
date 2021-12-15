require './lib/grid_of_stuff'
# require './../lib/grid_of_stuff'

RSpec.describe 'GridOfStuff' do
  describe '#recursively_find_from_point' do
    it 'finds points with no transformation' do
      rows = [
        [0, 0, 1, 0],
        [1, 0, 1, 0],
        [0, 0, 1, 1],
        [0, 0, 1, 0]
      ]
      grid = GridOfStuff.new(rows)
      expect(grid.recursively_find_from_point(1, 2) { |v, _| v == 1 }).to eq(
        {
          0 => {
            2 => 1,
          },
          1 => {
            2 => 1
          },
          2 => {
            2 => 1,
            3 => 1
          },
          3 => {
            2 => 1
          }
        }
      )
    end

    it 'finds points with transformation_if_true' do
      rows = [
        [0, 0, 1, 0],
        [1, 0, 1, 1],
        [0, 0, 1, 1],
        [0, 0, 1, 0]
      ]
      grid = GridOfStuff.new(rows)
      expect(grid.recursively_find_from_point(1, 2, transformation_if_true: ->(v, _) { v + 1 }) { |v, _| v == 1 }).to eq(
        {
          0 => {
            2 => 2,
          },
          1 => {
            2 => 2,
            3 => 2
          },
          2 => {
            2 => 2,
            3 => 2
          },
          3 => {
            2 => 2
          }
        }
      )
      expect(grid.rows).to eq([
        [0, 0, 2, 0],
        [1, 0, 2, 2],
        [0, 0, 2, 2],
        [0, 0, 2, 0]
      ])
    end
  end

  describe '#recursively_find_all' do
    it 'finds points with no transformation and no diagonals' do
      rows = [
        [0, 0, 1, 0],
        [1, 0, 1, 1],
        [1, 0, 1, 1],
        [0, 0, 1, 0]
      ]
      grid = GridOfStuff.new(rows)
      expect(grid.recursively_find_all { |v, _| v == 1 }).to eq(
        {
          0 => {
            2 => 1,
          },
          1 => {
            0 => 1,
            2 => 1,
            3 => 1
          },
          2 => {
            0 => 1,
            2 => 1,
            3 => 1
          },
          3 => {
            2 => 1
          }
        }
      )
    end

    it 'finds points with diagonals' do
      rows = [
        [0, 1, 0, 0],
        [1, 0, 0, 1],
        [1, 0, 1, 1],
        [0, 0, 1, 0]
      ]
      grid = GridOfStuff.new(rows)
      expect(grid.recursively_find_all(diagonal: true) { |v, _| v == 1 }).to eq(
        {
          0 => {
            1 => 1,
          },
          1 => {
            0 => 1,
            3 => 1
          },
          2 => {
            0 => 1,
            2 => 1,
            3 => 1
          },
          3 => {
            2 => 1
          }
        }
      )
    end

    it 'finds points with a transformation' do
      rows = [
        [0, 1, 0, 0],
        [0, 0, 3, 0],
        [1, 0, 0, 0],
        [0, 0, 0, 0]
      ]
      grid = GridOfStuff.new(rows)
      expect(grid.recursively_find_all(
        diagonal: true,
        transformation: ->(v, _) { v + 1 },
        transformation_if_true: ->(_, _) { 0 },
        transformation_if_false: ->(v, _) { v + 1 }
      ) { |v, _| v > 3 }).to eq(
        {
          1 => {
            2 => 0
          }
        }
      )
      expect(grid.rows).to eq([
        [1, 3, 2, 2],
        [1, 2, 0, 2],
        [2, 2, 2, 2],
        [1, 1, 1, 1]
      ])
    end
  end
end