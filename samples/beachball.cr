require "../lib/sdl"
require "../lib/sdl/game"
require "point"

width          = 640
height         = 480

# TODO: Turn this into two vectors!
# Does crystal have a good set of primitive math libraries?
# Can we contribute simple stuff like Point and Vector?

x              = 0
x_speed        = 10

y              = 0
y_speed        = 10

beachball      = SDL::Image.new("#{__DIR__}/beach_ball.png")
if beachball.nil?
  raise "Couldn't load beachball! Error: #{SDL.error}"
end

Game.go(width, height) do |screen|
  Game.exit_on_event!

  if (x + beachball.width > width) || (x < 0)
    x_speed = (-x_speed)
  end

  if (y + beachball.height > height) || (y < 0)
    y_speed = (-y_speed)
  end

  x += x_speed
  y += y_speed

  screen.fill(SDL::Color.from_hex("ffffff"))
  beachball.draw_onto(screen, Point.new(x, y))

  screen.flip
end
