require "../../lib/sdl"
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

pos    = SDL::Point.new(0, 0)
speed  = SDL::Vector.new(10, 10)
image  = SDL::Image.new("#{__DIR__}/beach_ball.png")

size   = {640, 480}

ball   = Ball.new(pos, speed, image)

screen = SDL::Display.new(size)

loop do
  SDL.poll_events do |event|
    exit if event.quit?
  end

  if ball.x_collides?(screen)
    ball.x_speed = (-ball.x_speed)
  end

  if ball.y_collides?(screen)
    ball.y_speed = (-ball.y_speed)
  end

  ball.move!

  screen.fill(SDL::Color.black)
  ball.draw_onto(screen)

  screen.flip
end
