# frozen_string_literal: true

module Dispersion
  class Annotation
    include Comparable

    def initialize(type, location)
      @type = type
      @location = location
    end

    attr_reader :type, :location

    def <=>(other)
      comparison_value <=> other.comparison_value
    end

    def comparison_value
      [
        location,
        (type == :reset ? 0 : 1)
      ]
    end

    def to_ary
      [type, location]
    end
  end
end
