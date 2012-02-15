require 'test_helper'

class MultiRangeTest < Test::Unit::TestCase
  def test_add
    range = MultiRange.new

    range.add(12)
    range.add(15)
    assert_equal [(12..15)], range.to_a

    range.add(17)
    assert_equal [(12..17)], range.to_a

    assert_raise(ArgumentError) { range.add(16) }
  end

  def test_close
    range = MultiRange.new
    range.add(12)
    range.add(15)

    range.close
    range.add(19)
    range.add(21)
    range.close
    range.add(25)
    range.add(30)
    assert_equal [(12..15), (19..21), (25..30)], range.to_a
  end
end
