class PointsController < ApplicationController
    def index
        @points = Point.all
        @lines = Line.all
        respond_to do |format|
            format.html
            format.json {render json: @points }
        end
        @rank = distance(@points, @lines)
    end
    
    def create
        @point = Point.new(point_params)
        if @point.save
            render json: @point, status: :created
        else
            render json: @point.errors, status: :unprocessable_entity
        end
    end

    def detail
        @points = Point.all
        @lines = Line.all
        @rank = distance(@points, @lines)
    end

    def side_distance
        @points = Point.all
        @lines = Line.all
    end


    def destroy
        @point = Point.find(params[:id])
        @point.destroy

        flash[:success] = 'Pointは正常に削除されました'
    end

    private
    require 'matrix'

    def point_params
        params.require(:point).permit(:x, :y)
    end


    def distance(points, lines) #定形フレームワークの判定を行う
        m = []
        n = points.size
        p n

        lines.each do |line|
            e_line = []
            points.each do |point|
              if line.source.id == point.id
                p1 = ((2 * (line.target.x - point.x))*(10.pow(1))).to_i 
                p3 = ((2 * (line.target.y - point.y))*(10.pow(1))).to_i
                e_line << p1
                e_line << p3
              elsif line.target.id == point.id
                p2 = ((2 * (line.source.x - point.x))*(10.pow(1))).to_i
                p4 = ((2 * (line.source.y - point.y))*(10.pow(1))).to_i
                e_line << p2
                e_line << p4
              else
                e_line << 0
                e_line << 0
              end
            end
            m << e_line
        end
        i = Matrix[*m]
        rational_matrix = i.map { |x| x.to_r }
        p rational_matrix
        r = rational_matrix.rank 
        p r

        if (2 * n - 3 == r)
            word = '定形である'
        elsif (2 * n - 3 > r)
            word = '変形する'
        else
            word = '判定出来ませんでした'
        end
        
    end


    
end
