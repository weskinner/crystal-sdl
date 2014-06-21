
require "../lib/sdl"
require "../lib/sdl/game"
require "life"


life = Life.new(64, 48)

Game.start(640, 480) do |screen|
  if screen.nil?
    raise "Couldn't initialize game with screen!"
  else
    life.draw_onto(screen)
    life.next!

    Game.poll(screen) do |event|
      if event.quit?
        Game.quit
        exit
      end
    end
  end
end
