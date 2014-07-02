require "../lib/sdl"
require "../lib/sdl/game"
require "point"

width  = 640
height = 480

i = 0

beachball_file = "#{__DIR__}/beach_ball.png"
beachball      = SDL::Image.new(beachball_file)

if beachball.nil?
  raise "Couldn't load beachball! Error: #{SDL.error}"
end

Game.go(width, height) do |screen|
  Game.exit_on_event!

  if i > width
    i = 0
  end

  screen.fill(SDL::Color.from_hex("ffffff"))
  beachball.draw_onto(screen, Point.new(i, 30))

  i += 1

  screen.flip
end
