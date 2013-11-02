require_relative 'sudoku/cell_group'
require_relative 'sudoku/puzzle'
require_relative 'sudoku/generator'


module Sudoku
  class Unsolvable < StandardError; end
end