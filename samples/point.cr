# TODO: What makes Point different from vector?
# Perhaps Point is just struct with some methods?
class Point
  property :x
  property :y

  def initialize(@x, @y)
  end

  def +(other)
    Point.new(self.x + other.x, self.y + other.y)
  end
end
