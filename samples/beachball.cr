require "../lib/sdl"

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


width = 640
height = 480

puts SDL.version.to_s

SDL.init
SDL.show_cursor

beachball = SDL::Image.new("beach_ball.png")

puts beachball.to_s

if beachball.nil?
  puts "Couldn't load beachball!"
  puts SDL.error
  s = SDL::Image.error
end

puts "Creating main surface"
screen = SDL.set_video_mode width, height, 32, LibSDL::DOUBLEBUF | LibSDL::HWSURFACE | LibSDL::ASYNCBLIT

puts "Starting loop"
loop do
  beachball.draw_onto(screen, Point.new(30, 30))
  # Draw images!

  screen.flip

  SDL.poll_events do |event|
    if event.type == LibSDL::QUIT || event.type == LibSDL::KEYDOWN
      SDL.quit
      exit
    end
  end
end
