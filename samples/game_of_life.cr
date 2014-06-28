require "../lib/sdl"
require "../lib/sdl/game"
require "life"

# TODO: Print out the FPS for game of life,
# so we can compare it to:
#
# 1) A pure C version
# 2) A pure Ruby version
# 3) A pure Java version

width  = 640
height = 480
size   = 2

life = Life.new(width / size, height / size, 0.5)

Game.go(width, height) do |screen|
  Game.exit_on_event!

  life.draw_onto(screen, size)
  life.next!
end
