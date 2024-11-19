class LinesController < ApplicationController
  def index
  end

  def create
    source_point = Point.find(params[:line][:source_id])
    target_point = Point.find(params[:line][:target_id])
    @line = Line.new(source: source_point, target: target_point)
    # @line.save!
    if @line.save
      render json: @line, status: :created
    else
      render json: @line.errors, status: :unprocessable_entity
    end

    # redirect_to points_url
  end

  def destory
  end

  private

  def line_params
    params.require(:line).permit(:source, :target)
  end
end
