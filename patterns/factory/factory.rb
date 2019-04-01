# Factory pattern is one of the creational patterns. It fits perfectly
# when we don't exactly know what is the type of the object that we
# need to create and when decision about this initialization needs to
# be done during the runtime. Another great property of factory pattern
# is the ability to encapsulate complex logic related to object creation.
class ShapeFactory
  class << self
    def get_shape(type = nil)
      shapes[type.to_s.downcase].new
    end

    private

    def shapes
      @shapes ||= Hash.new(NullShape).tap do |h|
        h['circle']    = Circle
        h['rectangle'] = Rectangle
      end
    end
  end

  # Shape is a general form of abstraction that defines public interafce
  # and behavior shared between all specific subtypes.
  class Shape
    def draw
      raise 'draw() method needs to be implemented in subclass'
    end

    def print_pretty_drawing
      print ['Preety drawing:', draw].reject(&:blank?).join(' ')
    end
  end

  # NullShape is a specific form of abstraction that conforms Shape
  # contract and represents logic related to nil value. It is example
  # of NullObject pattern as well.
  class NullShape < Shape
    def draw
      nil
    end
  end

  # Circle is a specific form of abstraction that conforms Shape
  # contract and represents logic related to drawing circles.
  class Circle < Shape
    def draw
      puts 'Drawing circle logic...'
    end
  end

  # Rectangle is a specific form of abstraction that conforms Shape
  # contract and represents logic related to drawing rectangles.
  class Rectangle < Shape
    def draw
      puts 'Drawing rectangle logic...'
    end
  end
end

# Example usage:

shape = ShapeFactory.get_shape('Circle')
shape.print_pretty_drawing
