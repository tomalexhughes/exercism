class Matrix
  def initialize(matrix)
    @rows = matrix
            .split(/\n/)
            .map { |r| r.split(' ').map(&:to_i) }

    @columns = @rows.transpose
  end

  def row(row_number)
    @rows[row_number - 1]
  end

  def column(col_number)
    @columns[col_number - 1]
  end
end

