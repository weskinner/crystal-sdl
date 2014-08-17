module SDL
  class Rect
    property :rect

    def initialize(@rect)
    end

    def initialize(x, y, w, h)
      @rect = LibSDL::Rect.new
      @rect.x = x.to_i16
      @rect.y = y.to_i16
      @rect.w = w.to_u16
      @rect.h = h.to_u16
    end

    def +(other)
      Rect.new(
        @rect.x + other.x,
        @rect.y + other.y,
        @rect.w, @rect.h)
    end

    def pointer
      # @rect
      pointerof(@rect)
    end
  end
end
