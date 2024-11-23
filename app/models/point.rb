class Point < ApplicationRecord
    before_create :reuse_deleted_id

    has_many :source_lines, class_name: 'Line', foreign_key: 'source', dependent: :destroy
    has_many :target_lines, class_name: 'Line', foreign_key: 'target', dependent: :destroy

    private

    def reuse_deleted_id
        # ID の最大値を取得。レコードがない場合は 0 を代入
        max_id = Point.maximum(:id) || 0
        # 使用されていない最小のIDを検索
        unused_id = (1..max_id).find { |id| Point.find_by(id: id).nil? } || max_id + 1
        self.id = unused_id if unused_id
    end

end
