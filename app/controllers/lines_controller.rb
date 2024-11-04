class LinesController < ApplicationController
  def index
  end

  def create
    @line = Line.new(line_params)
    # @line.save!
    if @line.save
      render json: @line, status: :created
    else
      render json: @line.errors, status: :unprocessable_entity
    end
  end

  def destory
  end

  private

  def line_params
    params.require(:line).permit(:source, :target)
  end
end
