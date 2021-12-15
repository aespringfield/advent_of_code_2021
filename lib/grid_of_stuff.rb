class GridOfStuff
  attr_reader :rows, :points_found

  def initialize(rows)
    @rows = rows
    @points_found = {}
  end

  def is_in_bounds?(row_i, col_i)
    row_i >= 0 && row_i < @rows.length && col_i >= 0 && col_i < @rows[row_i].length
  end

  def move_from_point(row_i, col_i, up: 0, left: 0, down: 0, right: 0)
    new_row_i = row_i - up + down
    new_col_i = col_i - left + right
    value = is_in_bounds?(new_row_i, new_col_i) ? value_at(new_row_i, new_col_i) : nil
    [value, [new_row_i, new_col_i]]
  end

  def recursively_find_from_point(row_i, col_i, **opts, &block)
    opts = recursively_find_default_opts.merge(opts)
    value = @rows[row_i][col_i]

    if !@points_found[row_i]&.[](col_i)
      if block.call(value, [row_i, col_i])
        @points_found[row_i] ||= {}
        @points_found[row_i][col_i] = @rows[row_i][col_i] = opts[:transformation_if_true].call(value, [row_i, col_i])
        opts[:instructions].each do |instruction|
          _, (new_row_i, new_col_i) = move_from_point(row_i, col_i, **instruction)
          recursively_find_from_point(new_row_i, new_col_i, **opts, recurring: true, &block) if is_in_bounds?(new_row_i, new_col_i)
        end
      elsif opts[:recurring]
        @rows[row_i][col_i] = opts[:transformation_if_false].call(value, [row_i, col_i])
        recursively_find_from_point(row_i, col_i, **opts, recurring: false, &block)
      end
    end

    @points_found
  end

  def value_at(row_i, col_i)
    @rows[row_i][col_i]
  end

  def recursively_find_all(**opts, &block)
    # TODO: don't store this in mutating instance variable
    @points_found = {}

    opts = recursively_find_all_default_opts
      .merge({
        instructions: [
          *orthogonal_movement_instructions,
          *(opts[:diagonal] && diagonal_movement_instructions)
        ],
        **opts
      })

    @rows.each_with_index do |row, row_i|
      row.each_with_index do |value, col_i|
        if !@points_found[row_i]&.[](col_i)
          @rows[row_i][col_i] = new_value = opts[:transformation].call(value, [row_i, col_i])
            if block.call(new_value, [row_i, col_i])
              recursively_find_from_point(row_i, col_i,  **opts, &block)
            end
          end
      end
    end

    points_found
  end

  def find_all(&block)
    @rows.each_with_object([]).with_index do |(row, memo), row_i|
      row.each_with_index do |value, col_i|
        memo << [value, [row_i, col_i]] if block.call(value, [row_i, col_i])
      end
    end
  end

  def transform_all(&block)
    @rows.each_with_index do |row, row_i|
      row.each_with_index do |value, col_i|
        @rows[row_i][col_i] = block.call(value, [row_i, col_i])
      end
    end
  end

  private

  def recursively_find_default_opts
    {
      instructions: orthogonal_movement_instructions,
      transformation_if_true: ->(v, _) { v },
      transformation_if_false: ->(v, _) { v }
    }
  end

  def recursively_find_all_default_opts
    {
      transformation: ->(v, _) { v },
      instructions: orthogonal_movement_instructions,
      diagonal: false
    }
  end

  def orthogonal_movement_instructions
    [{right: 1}, {down: 1}, {left: 1}, {up: 1} ]
  end

  def diagonal_movement_instructions
    [{down: 1, right: 1}, {down: 1, left: 1}, {up: 1, right: 1}, {up: 1, left: 1}]
  end

  def clone_nested_hash(hsh)
    hsh.each_with_object({}) do |(k, v), memo|
      memo[k] ||= {}
      memo[k] = v.each_with_object({}) { |(k2, v2), memo2| memo2[k2] = v2 }
    end
  end
end
