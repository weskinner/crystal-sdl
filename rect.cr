
module SDL
  class Rect
    property :rect

    def initialize(@rect)
    end

    def pointer
      pointerof(@rect)
    end

    def initialize(x : Int16, y : Int16, w : UInt16, h : UInt16)
      @rect = LibSDL::Rect.new
      @rect.x = x
      @rect.y = y
      @rect.w = w
      @rect.h = h
    end

    def +(other)
      Rect.new(
        @rect.x + other.x,
        @rect.y + other.y,
        @rect.w, @rect.h)
    end

    def self.from(image)
      Rect.new(0.to_i16, 0.to_i16, image.value.w.to_u16, image.value.h.to_u16)
    end
  end
end
