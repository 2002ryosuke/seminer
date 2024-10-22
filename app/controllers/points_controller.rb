class PointsController < ApplicationController
    def index
        @points = Point.all
        # respond_to do |format|
        #     format.html
        #     format.json {render json: @points }
        # end
    end
    
    def create
        @point = Point.new(point_params)
        if @point.save
            render json: @point, status: :created
        else
            render json: @point.errors, status: :unprocessable_entity
        end
        # @points = Point.all
    end


    private

    def point_params
        params.require(:point).permit(:x, :y)
    end
    
end
