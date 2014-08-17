require "../../lib/sdl"
require "../../lib/sdl/game"
require "../point"

SCREEN_WIDTH  = 640
SCREEN_HEIGHT = 480

class Block
  def initialize(@x, @y, @size)
  end

  def rect
    SDL::Rect.new(@x*@size, @y*@size, @size - 1, @size - 1).pointer
  end

  def draw_onto(screen)
    screen.fill(SDL::Color.blue, rect)
  end
end

class Player
  def initialize(@width = 75, @height = 15, @speed = 5)
    @x = ((SCREEN_WIDTH / 2.0) - (@width / 2.0)).to_i
    @y = SCREEN_HEIGHT - @height
  end

  def rect
    SDL::Rect.new(@x, @y, @width, @height).pointer
  end

  def draw_onto(screen)
    screen.fill(SDL::Color.white, rect)
  end

  def handle(event)
    if event.arrow_left?
      @x -= @speed
    end

    if event.arrow_right?
      @x += @speed
    end
  end
end

player = Player.new

blocks = [] of Block

(0..5).each do |y|
  (0..32).each do |x|
    blocks << Block.new(x, y, 20)
  end
end

Game.go(SCREEN_WIDTH, SCREEN_HEIGHT) do |screen|
  Game.poll do |event|
    if event.quit?

      Game.quit
      exit
    elsif event.keydown?
      player.handle(event)
    end
  end

  screen.fill(SDL::Color.black)

  blocks.each do |block|
    block.draw_onto(screen)
  end

  player.draw_onto(screen)

  screen.flip
end
