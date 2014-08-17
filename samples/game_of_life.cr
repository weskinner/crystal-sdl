# TODO: Print out the FPS for game of life,
# so we can compare it to:
#
# 1) A pure C version
# 2) A pure Ruby version
# 3) A pure Java version

class Life
  property grid
  property width
  property height

  def initialize(@width, @height, @p = 0.5)
    @grid = rows.map do |i|
      cols.map do |j|
        (rand < @p) ? true : false
      end
    end
  end

  def neighbors(i,j)
    si = Math.max(0, i-1)
    ei = Math.min(i+1, @width-1)

    sj = Math.max(0, j-1)
    ej = Math.min(j+1, @height-1)

    total = 0
    (si..ei).each do |n|
      (sj..ej).each do |m|
        total += 1 if @grid[n][m]
      end
    end
    total
  end

  # True = Alive, False = Dead
  def fate(i, j)
    if @grid[i][j]
      if neighbors(i, j) < 2
        false # Underpopulation
      elsif neighbors(i,j) < 4
        true # Stable
      elsif neighbors(i,j) > 3
        false # Overpopulation
      else
        @grid[i][j]
      end
    else
      if neighbors(i,j) == 3
        true # Reproduction
      else
        @grid[i][j]
      end
    end
  end

  def next!
    @grid = rows.map do |i|
      cols.map do |j|
        fate(i, j)
      end
    end
  end

  def rows
    (0..(@width-1))
  end

  def cols
    (0..(@height-1))
  end

  def draw_onto(screen, size = 10)
    rows.each do |i|
      cols.each do |j|
        rect = SDL::Rect.new(i*size, j*size, size, size)
        if @grid[i][j]
          screen.fill(SDL::Color.white, rect.pointer)
        else
          screen.fill(SDL::Color.black, rect.pointer)
        end
      end
    end
  end
end

screen_size = {640, 480}
size = 2

life = Life.new(screen_size[0] / size, screen_size[1] / size, 0.5)

until SDL.poll_event.keydown?
  life.draw_onto(screen, size)
  life.next!
end
