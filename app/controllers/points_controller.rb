class PointsController < ApplicationController
    def create
        @point = Point.new(point_params)
        if @point.save
            render json: @point, status: :created
        else
            render json: @point.errors, status: :unprocessable_entity
        end
    end

    private

    def point_params
        params.require(:point).permit(:x, :y)
    end
    
end
