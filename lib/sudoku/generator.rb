module Sudoku
  class Generator
    def self.generate hints
      puzzle = Puzzle.new
      (0...81).to_a.sample(hints).each do |i|
        x, y = i.divmod(9)
        available = puzzle.available_values x, y
        raise Sudoku::Unsolvable if available.length == 0
        puzzle[x, y] = available.sample
      end
      puzzle
    end
  end
end