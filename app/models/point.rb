class Point < ApplicationRecord
    has_many :source_lines, class_name: 'Line', foreign_key: 'source', dependent: :destroy
    has_many :target_lines, class_name: 'Line', foreign_key: 'target', dependent: :destroy
end
