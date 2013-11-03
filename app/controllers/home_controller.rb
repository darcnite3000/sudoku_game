require 'sudoku'
require 'json'
class HomeController < ApplicationController
  def index
    redirect_to :generate_medium
  end
  
  def easy_puzzle
    @puzzle = Sudoku::Generator.generate 30
    render :index
  rescue Sudoku::Unsolvable
    render :unsolvable
  end
  
  def medium_puzzle
    @puzzle = Sudoku::Generator.generate 20
    render :index
  rescue Sudoku::Unsolvable
    render :unsolvable
  end

  def hard_puzzle
    @puzzle = Sudoku::Generator.generate 15
    render :index
  rescue Sudoku::Unsolvable
    render :unsolvable
  end
  
  def values
    puzzle = Sudoku::Puzzle.new params[:cells]
    
    respond_to do |format|
      format.json { render json: puzzle.available_values(params[:cell][0],params[:cell][1]) }
    end
  end
end
