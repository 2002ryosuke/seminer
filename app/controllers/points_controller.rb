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

    def matrix_rank(matrix)
        # 行列をコピーして破壊的に変更するため
        a = matrix.to_a.map(&:dup)
        rows = a.length
        cols = a[0].length
      
        rank = 0
        i = 0
        j = 0
      
        while i < rows && j < cols
          # ピボットを探す
          pivot_row = i
          (i...rows).each do |k|
            if a[k][j] != 0
              pivot_row = k
              break
            end
          end
      
          if a[pivot_row][j] == 0
            j += 1
            next
          end
      
          # ピボット行を先頭に持ってくる
          a[i], a[pivot_row] = a[pivot_row], a[i]
      
          # ピボットの下の行を掃き出す
          (i + 1...rows).each do |k|
            factor = Rational(a[k][j].to_r,  a[i][j].to_r)
            p factor
            (j...cols).each do |l|
              a[k][l] -= factor * a[i][l]
            end
          end
      
          rank += 1
          i += 1
          j += 1
        end
      
        rank
      end


    # def rank(matrix) #ランクの計算自作  
    #     m = matrix.to_a
    #     p m
    #     line_size = m.size



        # #もし、辺が作成されていなかった場合
        # if m[0] == nil
        #     return 0
        # else 
        #     point_size = m[0].size

        #     rank = 0
        #     i = 0
        #     j = 0
        #     # ピボットを探す処理
        #     while i < line_size
        #         j = 0
        #         while j < point_size
        #             if m[i][j] != 0
        #                 pivot_row = i
        #                 pivot = m[i][j] 
        #                 break
        #             end
        #             rank += 1
        #             j += 1
        #         end
        #     if pivot != nil
        #         break
        #     end
        #     i += 1
        #     end
        #     p pivot
        #     p pivot_row
        #     #ピボットのある行を最初の行に持ってくる
        #     if i != 0
        #         m[0] = m[i]
        #         m[i] = m[0]
        #     end
        #     #ピボットの行をiとしていて、その列が０になるように計算式をたてて、計算する
        #     (i+1..line_size).each do |a|
        #         factor = m[a][j].to_r / m[i][j]
        #         (j..point_size).each do |b|
        #             m[k][b] -= factor * m[i][b]
        #         end
        #     end
            
        # end
    # end

    def degree(point_num, line_num)
      points = []
      lines = []

      point_num.each do |point|
        points << point.id
      end

      line_num.each do |line|
        line_f = []
        line_f << line.source.id
        line_f << line.target.id
        lines << line_f
      end

      degree = {}
      count = 0

      points.each do |point|
        count = 0
        lines.each do |line|
          line.each do |p|
            if point == p
              count += 1
            end
          end
        end
        degree[point] = count
    end
    return degree
  end


  def isolated_point(points, lines)
  degree = degree(points, lines)
      count = 0
      count1 = 0
      p degree
      points.each do |point|
        if degree[point.id] == 0
          count += 1
        elsif degree[point.id] == 1
          count1 += 1
        end
      end
      p count

      if points.size == 1
        return 1 #孤立点が存在している
      elsif count != 0
        return 2 #連結グラフではない
      elsif lines.size != 1 && count1 >= 1
        return 3 #連結グラフではない
      end
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
        # rational_matrix = i.map { |x| x.to_r }
        
        # b = matrix_rank(i)
        r = i.rank 
        # p b
        p r

        if isolated_point(points, lines) == 1
          return '孤立点で定形である'
        elsif isolated_point(points, lines) == 2
          return '連結グラフではない'
        elsif isolated_point(points, lines) == 3
          return '端点が存在する もしくわ 連結グラフではない'
        elsif (2 * n - 3 == r)||(r == 1)
            return '定形である'
        elsif (2 * n - 3 > r)
            return '変形する'
        else
            return '判定出来ませんでした'
        end
        
    end


    
end
