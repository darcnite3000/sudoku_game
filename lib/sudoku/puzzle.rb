module Sudoku
  class Puzzle
    
    Blocks = 
      [
        0,0,0,1,1,1,2,2,2,
        0,0,0,1,1,1,2,2,2,
        0,0,0,1,1,1,2,2,2,
        3,3,3,4,4,4,5,5,5,
        3,3,3,4,4,4,5,5,5,
        3,3,3,4,4,4,5,5,5,
        6,6,6,7,7,7,8,8,8,
        6,6,6,7,7,7,8,8,8,
        6,6,6,7,7,7,8,8,8
      ].freeze
    ValidValueRange = (0..9).freeze
    
    def initialize puzzle=Array.new(Blocks.length)
      @cells = Array.new(puzzle.map!(&:to_i)) if puzzle.length == Blocks.length
      @cells.map!{ |cell| ValidValueRange === cell ? cell : 0 }
    end
    
    def []= x,y,value
      @cells[coord_to_pos x, y] = value.to_i if ValidValueRange === value.to_i
    end
    
    def [] x,y
      @cells[coord_to_pos x, y] ||= 0
    end
    
    def to_a
      @cells
    end
    
    def solved?
      9.times do |i|
        return false unless column(i).solved? && row(i).solved? && block(i).solved?
      end
      true
    end
    
    def valid?
      9.times do |i|
        return false unless column(i).valid? && row(i).valid? && block(i).valid?
      end
      true
    end
    
    def available_values x, y
      r,c,b = cell_groups x, y
      cell = @cells[coord_to_pos x, y]
      values = (1..9).to_a - r.to_a - c.to_a - b.to_a
      if cell != 0
        values = values + [cell]
      end
      values.sort
    end
    
    def cell_groups x, y
      return row(y), column(x), block(Blocks[coord_to_pos x, y])
    end
    
    def column x
      group = CellGroup.new
      x.step(80,9){|i| group << @cells[i] }
      group
    end
    
    def row y
      CellGroup.new(@cells[(y*9)..((y+1)*9)])
    end
    
    def block position
      group = CellGroup.new
      @cells.each_index do |index|
        group << @cells[index] if Blocks[index] == position
      end
      group
    end
    
    private
    def coord_to_pos x,y
      y*9 + x
    end
    def pos_to_coord cell
      cell.divmod 9
    end 
  end
  
end