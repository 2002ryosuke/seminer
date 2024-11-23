require "test_helper"

class PointTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "id count" do
    Point.transaction do
      Point.create!
      raise ActiveRecord::Rollback
    end
    Point.create!
    assert_equal 1, Point.count
    assert_equal Point.count, Point.last.id
  end
end
