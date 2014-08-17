module SDL
  class Surface
    getter surface
    getter width
    getter height
    getter bpp

    def initialize(@surface, @width, @height, @bpp)
    end

    def format
      @surface.value.format
    end

    def source
      @surface
    end

    def each_row
      (0).upto(width - 1) do |i|
        yield i
      end
    end

    def each_col
      (0).upto(height - 1) do |i|
        yield j
      end
    end

    def lock
      LibSDL.lock_surface @surface
    end

    def unlock
      LibSDL.unlock_surface @surface
    end

    def update_rect(x, y, w, h)
      LibSDL.update_rect @surface, x, y, w, h
    end

    def flip
      LibSDL.flip @surface
    end

    def fill(color)
      fill(color, SDL::Rect.from(@surface))
    end

    def fill(color, rect : SDL::Rect)
      color_as_int = LibSDL.map_rgb(@surface.value.format, color.r, color.g, color.b)
      LibSDL.fill_rect(@surface, rect.pointer, color_as_int)
    end

    def fill(color, rect : Pointer(LibSDL::Rect))
      color_as_int = LibSDL.map_rgb(@surface.value.format, color.r, color.g, color.b)
      LibSDL.fill_rect(@surface, rect, color_as_int)
    end

    def blit(image, point)
      start_rect = SDL::Rect.from(image)
      end_rect   = start_rect + point
      LibSDL.blit_surface image, start_rect.pointer, @surface, end_rect.pointer
    end

    def [](offset)
      (@surface.value.pixels as UInt32*)[offset].to_u32
    end

    def []=(offset, color)
      (@surface.value.pixels as UInt32*)[offset] = color.to_u32
    end

    def []=(x, y, color)
      self[y.to_i32 * @width + x.to_i32] = color
    end

    def offset(x, y)
      x.to_i32 + (y.to_i32 * @width)
    end

    def rect
      SDL::Rect.new(0, 0, @width, @height)
    end
  end
end
