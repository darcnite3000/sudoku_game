module Sudoku
  class Print
    def self.print puzzle
      9.times {|i| puts puzzle.row(i).to_a.join }
      puzzle
    end
  end
end