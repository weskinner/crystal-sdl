# require "sdl"

require "lib_sdl"

class Point
  property :x
  property :y

  def initialize(@x, @y)
  end
end

class Version
  def initialize(@version)
  end

  def to_s
    "#{@version.value.major}.#{@version.value.minor}.#{@version.value.patch}"
  end
end

lib LibSDL_image("SDL_image")
  fun get_error = IMG_GetError() : UInt8*
  fun load = IMG_Load(file : UInt8*) : LibSDL::Surface*
end

module SDL
  def self.version
    Version.new(LibSDL.version)
  end

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

  class Image
    def self.error
      String.new LibSDL_image.get_error
    end

    property :image
    property :file_name

    def initialize(@file_name)
      @image = LibSDL_image.load(@file_name)
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

    def draw_onto(surface : SDL::Surface, at : Point)
      source = SDL::Rect.from(@image)
      destination = source + at
      # LibSDL.blit_surface @image, source.pointer, surface.surface, destination.pointer
    end
  end
end

width = 640
height = 480

puts SDL.version.to_s

SDL.init
SDL.show_cursor

# beachball = SDL::Image.new("beach_ball.png")

# puts beachball.to_s

# if beachball.nil?
#  puts "Couldn't load beachball!"
#  puts SDL.error
  # s = SDL::Image.error
# end


puts "Creating main surface"
surface = SDL.set_video_mode width, height, 32, LibSDL::DOUBLEBUF | LibSDL::HWSURFACE

puts "Starting loop"
loop do
  # beachball.draw_onto(surface, Point.new(30, 30))
  # Draw images!

  SDL.poll_events do |event|
    if event.type == LibSDL::QUIT || event.type == LibSDL::KEYDOWN
      SDL.quit
      exit
    end
  end
end
