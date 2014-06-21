
require "../lib/sdl"
require "../lib/sdl/game"
require "life"

life = Life.new(64, 48)

Game.go(640, 480) do |screen|
  life.draw_onto(screen)
  life.next!

  Game.poll do |event|
    if event.quit?
      Game.quit
      exit
    end
  end
end
