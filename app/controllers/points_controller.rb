class PointsController < ApplicationController
    def index
        @points = Point.all
        @lines = Line.all
        respond_to do |format|
            format.html
            format.json {render json: @points }
        end
    end
    
    def create
        @point = Point.new(point_params)
        if @point.save
            render json: @point, status: :created
        else
            render json: @point.errors, status: :unprocessable_entity
        end
        
        # @line = Line.new(line_params)
        # if @line.save
        #     render json: @line, status: :create
        # else
        #  render json: @line.errors, status: :unprocessable_entity
        # end
    end

    def destroy
        @point = Point.find(params[:id])
        @point.destroy

        flash[:success] = 'Pointは正常に削除されました'
        # redirect_to points_url
    end


    private

    def point_params
        params.require(:point).permit(:x, :y)
    end

    # def line_params
    #     params.require(:line).permit(:source, :target)
    # end
    
end
