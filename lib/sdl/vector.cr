
module SDL
  class Vector
    property :x
    property :y

    def initialize(@x, @y)
    end

    def +(other)
      Vector.new(self.x + other.x, self.y + other.y)
    end
  end
end
