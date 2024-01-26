# frozen_string_literal: true

module CoreExt
  module Range
    # Input:
    # (1..9).intersect((5..14))
    # (1..9) & (11..14)
    # (Time.current..Time.current + 3.day).intersect((Time.current + 2.day..Time.current + 10.day))
    # (Time.current..Time.current + 3.day) & (Time.current + 2.day..Time.current + 10.day)
    #
    # Output:
    # 5..9
    # nil
    # Time.current + 2.day..Time.current + 3.day
    # Time.current + 2.day..Time.current + 3.day
    #
    def intersect(other)
      return nil if (self.end < other.begin) || (other.end < self.begin)

      [self.begin, other.begin].max..[self.end, other.max].min
    end

    alias & intersect

    # Input:
    # (1..9).intersect?((5..14))
    # (1..9).intersect?((9..14))
    # (1..9).intersect?((11..14))
    #
    # Output:
    # true
    # true
    # false
    #
    def intersect?(other)
      return false if (self.end < other.begin) || (other.end < self.begin)

      true
    end

    # Input:
    # (1..9).distance
    # (Time.current.yesterday..Time.current).distance
    #
    # Output:
    # 8
    # 86400
    #
    def distance
      (self.end - self.begin)
    end

    # Input:
    # (3..8).intersect_array([1..4, 5..10, 11..12])
    #
    # Output:
    # [3..4, 5..8]
    #
    def intersect_array(array_range)
      array_range.filter_map do |range|
        intersect(range)
      end.compact
    end
  end
end

Range.prepend(CoreExt::Range)
