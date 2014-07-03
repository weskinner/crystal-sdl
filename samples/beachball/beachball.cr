require "../lib/sdl"
require "../lib/sdl/game"
require "point"
require "vector"

width  = 640
height = 480

# TODO: Turn this into two vectors!
# Does crystal have a good set of primitive math libraries?
# Can we contribute simple stuff like Point and Vector?

class Ball

  property :point
  property :speed
  property :image

  def initialize(@point, @speed, @image)
  end

  def x
    @point.x
  end

  def x=(other)
    @point.x = other
  end

  def x_speed
    @speed.x
  end

  def x_speed=(other)
    @speed.x = other
  end

  def y
    @point.y
  end

  def y=(other)
    @point.y = other
  end

  def y_speed
    @speed.y
  end

  def y_speed=(other)
    @speed.y = other
  end

  def width
    image.width
  end

  def height
    image.height
  end

  def x_collides?(screen)
    ((@point.x + width) > screen.width) || (x < 0)
  end

  def y_collides?(screen)
    ((@point.y + height) > screen.height) || (y < 0)
  end

  def move!
    @point.x -= @speed.x
    @point.y -= @speed.y
  end

  def draw_onto(screen)
    @image.draw_onto(screen, @point)
  end

end

pos    = Point.new(0, 0)
speed  = Vector.new(10, 10)
image  = SDL::Image.new("#{__DIR__}/beach_ball.png")

ball   = Ball.new(pos, speed, image)

Game.go(width, height) do |screen|
  Game.exit_on_event!

  if ball.x_collides?(screen)
    ball.x_speed = (-ball.x_speed)
  end

  if ball.y_collides?(screen)
    ball.y_speed = (-ball.y_speed)
  end

  ball.move!

  screen.fill(SDL::Color.from_hex("ffffff"))
  ball.draw_onto(screen)

  screen.flip
end
