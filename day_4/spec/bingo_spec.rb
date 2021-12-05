require './day_4/bingo.rb'
# require './../day_4/bingo.rb'

RSpec.describe 'Bingo' do
  # let(:data) { File.readlines('./day_4/spec/data.txt', chomp: true) }

  describe '#run' do
    it 'returns correct result for test data when finding winner' do
      expect(Bingo.run(file_path: './day_4/spec/data.txt')).to be(4512)
      # expect(Bingo.run(file_path: './data.txt')).to be(4512)
    end

    it 'returns correct result for test data when finding loser' do
      expect(Bingo.run(file_path: './day_4/spec/data.txt', last: true)).to be(1924)
      # expect(Bingo.run(file_path: './data.txt', last: true)).to be(1924)
    end
  end

  describe '#find_loser' do
    it 'returns correct result for test data' do
      call_sequence_string = "7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1"
      call_sequence = call_sequence_string.split(',')

      boards = [
        [
          %w[22 13 17 11 0],
          %w[8 2 23 4 24],
          %w[21 9 14 16 7],
          %w[6 10 3 18 5],
          %w[1 12 20 15 19]
        ],
        [
          %w[3 15  0  2 22],
          %w[9 18 13 17  5],
          %w[19  8  7 25 23],
          %w[20 11 10 24  4],
          %w[14 21 16 12  6]
        ],
        [
          %w[14 21 17 24  4],
          %w[10 16 15  9 19],
          %w[18  8 23 26 20],
          %w[22 11 13  6  5],
          %w[2  0 12  3  7]
        ]
      ]

      expect(Bingo.find_loser(call_sequence, boards)).to eq({
        last_number: '13',
        board: boards[1],
        selections: [
          [2, 2], #7
          [3,4], #4
          [1, 0], #9
          [1, 4], #5
          [3, 1], # 11
          [1, 3], # 17
          [2, 4],# 23
          [0, 3], # 2
          [0, 2], # 0
          [4, 0], # 14
          [4, 1], # 21
          [3, 3], # 24
          [3, 2], # 10
          [4, 2], # 16
          [1, 2]# 13
        ]
      })
    end
  end

  describe '#find_winner' do
    it 'recognizes that a board has won horizontally' do
      board1 = [%w[1 2 3 4 5], %w[6 7 8 9 10], %w[11 12 13 14 15], %w[16 17 18 19 20], %w[21 22 23 24 15]]
      call = %w[2 6 7 8 9 10 11]
      expect(Bingo.find_winner(call, [board1])).to eq({
        last_number: '10',
        board: [%w[1 2 3 4 5], %w[6 7 8 9 10], %w[11 12 13 14 15], %w[16 17 18 19 20], %w[21 22 23 24 15]],
        selections: [[0, 1], [1, 0], [1, 1], [1, 2], [1, 3], [1, 4]]
      })
    end

    it 'recognizes that a board has won vertically' do
      board1 = [%w[1 2 3 4 5], %w[6 7 8 9 10], %w[11 12 13 14 15], %w[16 17 18 19 20], %w[21 22 23 24 15]]
      call = %w[2 1 6 11 16 21 11]
      expect(Bingo.find_winner(call, [board1])).to eq({
        last_number: '21',
        board: [%w[1 2 3 4 5], %w[6 7 8 9 10], %w[11 12 13 14 15], %w[16 17 18 19 20], %w[21 22 23 24 15]],
        selections: [[0, 1], [0, 0], [1, 0], [2, 0], [3, 0], [4, 0]]
      })
    end
  end
end