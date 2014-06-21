require "../lib/sdl"

class Point
  property :x
  property :y

  def initialize(@x, @y)
  end
end

width = 640
height = 480

puts SDL.version.to_s

SDL.init
SDL.show_cursor

beachball_file = File.dirname(__FILE__) + "/beach_ball.png"

beachball = SDL::Image.new(beachball_file)
puts beachball.to_s

if beachball.nil?
  puts "Couldn't load beachball!"
  puts SDL.error
end

puts "Creating main surface"
screen = SDL.set_video_mode width, height, 32, LibSDL::DOUBLEBUF | LibSDL::HWSURFACE | LibSDL::ASYNCBLIT

puts "Starting loop"
i = 0
loop do
  SDL.poll_events do |event|
    if event.type == LibSDL::QUIT || event.type == LibSDL::KEYDOWN
      SDL.quit
      exit
    end
  end

  if i > width
    i = 0
  end

  screen.fill(SDL::Color.white)

  beachball.draw_onto(screen, Point.new(i, 30))

  i += 1

  screen.flip
end
