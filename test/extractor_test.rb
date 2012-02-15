require 'test_helper'

class ExtractorTest < Test::Unit::TestCase
  def test_extract
    data = [
      [12, 'a'],
      [17, 'b'],
      [16, 'a'],
      [14, 'a'],
      [21, 'b'],
      [23, 'c'],
      [15, 'b']
    ]
    result = Extractor.extract(data)
    expected = {
      'a' => [(12..14), (16..16)],
      'b' => [(15..15), (17..21)],
      'c' => [(23..23)]
    }
    assert_equal expected, result
  end
end
