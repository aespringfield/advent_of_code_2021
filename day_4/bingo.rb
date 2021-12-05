class Bingo
  def self.run(file_path: './day_4/data.txt', last: false)
    call_sequence_string, *board_strings = File.read(file_path).split("\n\n")
    call_sequence = call_sequence_string.split(',')
    boards = board_strings.map do |board_string|
      board_string.split("\n").map { |row_string| row_string.split(' ') }
    end

    if last
      result = self.find_loser(call_sequence, boards)
    else
      result = self.find_winner(call_sequence, boards)
    end

    self.find_unselected(result[:board], result[:selections]).sum * result[:last_number].to_i
  end

  def self.find_loser(call_sequence, boards)
    self.find_win_order(call_sequence, boards).last
  end

  def self.find_win_order(call_sequence, boards)
    win_order = []
    boards_left = boards.each_with_object({}).with_index { |(board, obj), i| obj[i] = board }

    call_sequence.each_with_object(Array.new(boards.length) { [] }) do |call_number, selections|
      winners_this_round = {}
      boards_left.each do |(board_i, board)|
        board.each.with_index do |row, row_i|
          break unless row.each.with_index do |num, col_i|
            if num == call_number
              selections[board_i] << [row_i, col_i]
              tallies = selections[board_i]
                .each_with_object({ rows: {}, columns: {} }) { |(selected_row, selected_col), obj|
                  obj[:rows][selected_row] = (obj[:rows][selected_row] || 0) + 1
                  obj[:columns][selected_col] = (obj[:columns][selected_col] || 0) + 1
                }

              horizontal_win = tallies[:rows]
                .select { |_, v| v == 5 }
                .keys
                .first

              vertical_win =
                horizontal_win.nil? && tallies[:columns]
                 .select { |_, v| v == 5 }
                 .keys
                 .first

              if horizontal_win || vertical_win
                winners_this_round[board_i] = {
                  last_number: call_number,
                  board: board,
                  selections: selections[board_i]
                }
                break
              end
            end
          end
        end
      end

      win_order.concat(winners_this_round.values) unless winners_this_round.empty?
      boards_left.reject! { |(i, _)| winners_this_round[i] }
      break if boards_left.keys.length == 0
    end

    return win_order
  end

  def self.find_winner(call_sequence, boards)
    result = nil

    call_sequence.each_with_object(Array.new(boards.length) { [] }) do |call_number, selections|
      break unless boards.each.with_index do |board, board_i|
        break unless board.each.with_index do |row, row_i|
          break unless row.each.with_index do |num, col_i|
            if num == call_number
              selections[board_i] << [row_i, col_i]
              tallies = selections[board_i]
                .each_with_object({ rows: {}, columns: {} }) { |(selected_row, selected_col), obj|
                  obj[:rows][selected_row] = (obj[:rows][selected_row] || 0) + 1
                  obj[:columns][selected_col] = (obj[:columns][selected_col] || 0) + 1
                }

              horizontal_win = tallies[:rows]
                .select { |_, v| v == 5 }
                .keys
                .first

              vertical_win =
                horizontal_win.nil? && tallies[:columns]
                  .select { |_, v| v == 5 }
                  .keys
                  .first

              if horizontal_win || vertical_win
                result = {
                  last_number: call_number,
                  board: board,
                  selections: selections[board_i]
                }
                break
              end
            end
          end
        end
      end
    end

    return result
  end

  def self.find_unselected(board, selections)
    unselected = []
    board.each.with_index do |row, row_i|
      row.each.with_index do |num, col_i|
        unselected << num.to_i if !selections.include?([row_i, col_i])
      end
    end
    unselected
  end
end