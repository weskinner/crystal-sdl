module SDL
  class Display
    property :width
    property :height

    def initialize(@size)
      if s = @size
        @screen = SDL.set_video_mode width, height, default_bpp, default_flags
      end
    end

    def width
      @width || @size.try(&.[0]) || default_width
    end

    def height
      @height || @size.try(&.[1]) || default_height
    end

    def initialize(@width, @height)
      @screen = SDL.set_video_mode @width, @height, default_bpp, default_flags
    end

    def initialize(@width, @height, @bpp)
      @screen = SDL.set_video_mode @width, @height, @bpp, default_flags
    end

    def initialize(@width, @height, @bpp, @flags)
      @screen = SDL.set_video_mode @width, @height, @bpp, @flags
    end

    def flip
      @screen.try do |s|
        LibSDL.flip s.source
      end
    end

    def fill(color)
      @screen.try {|s| fill(color, s.rect) }
    end

    def fill(color, rect : SDL::Rect)
      @screen.try do |s|
        color_as_int = LibSDL.map_rgb(s.format, color.r, color.g, color.b)
        LibSDL.fill_rect(s.source, rect.pointer, color_as_int)
      end
    end

    def fill(color, rect : Pointer(LibSDL::Rect))
      @screen.try do |s|
        color_as_int = LibSDL.map_rgb(s.format, color.r, color.g, color.b)
        LibSDL.fill_rect(s, rect, color_as_int)
      end
    end

    def blit(image, point)
      @screen.try do |s|
        start_rect = image.rect
        end_rect   = start_rect + point
        LibSDL.blit_surface image.source, start_rect.pointer, s.source, end_rect.pointer
      end
    end

    def default_height
      640
    end

    def default_width
      480
    end

    def default_bpp
      32
    end

    def default_flags
      LibSDL::DOUBLEBUF | LibSDL::HWSURFACE | LibSDL::ASYNCBLIT
    end
  end
end
