class Line < ApplicationRecord
    belongs_to :source, class_name: "Point", foreign_key: "source"
    belongs_to :target, class_name: "Point", foreign_key: "target"

    validates :source, presence: true
    validates :target, presence: true
end
