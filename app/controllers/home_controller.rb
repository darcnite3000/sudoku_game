require 'sudoku'
require 'json'
class HomeController < ApplicationController
  def index
    @puzzle = Sudoku::Generator.generate 15
  end
  def values
    puzzle = Sudoku::Puzzle.new params[:cells]
    
    respond_to do |format|
      format.json { render json: puzzle.available_values(params[:cell][0],params[:cell][1]) }
    end
  end
end
