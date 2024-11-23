class Line < ApplicationRecord
before_create :reuse_deleted_id

    belongs_to :source, class_name: "Point", foreign_key: "source"
    belongs_to :target, class_name: "Point", foreign_key: "target"

    validates :source, presence: true
    validates :target, presence: true

    private

    def reuse_deleted_id
        max_id = Line.maximum(:id) || 0
        unused_id = (1..max_id).find { |id| Line.find_by(id: id).nil? } || max_id + 1
        self.id = unused_id if unused_id
    end

end
