module SDL
  class Image
    property :image
    property :file_name

    def initialize(@file_name)
      @image = LibSDL_image.load(@file_name)
      if @image.nil?
        raise "Image for #{@file_name} is not available!"
      end
    end

    def width
      @image.value.w
    end

    def height
      @image.value.h
    end

    def to_s
      "Surface: file_name=#{@file_name}, width=#{width}, height=#{height}"
    end

    def draw_onto(surface : SDL::Surface, point : Point)
      image = Surface.new(@image, @image.value.w, @image.value.h, 32)
      surface.blit(@image, point)
    end
  end
end
