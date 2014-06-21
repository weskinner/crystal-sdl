
class Life
  property :grid
  property :width
  property :height

  def initialize(@width, @height)
    @grid = rows.map do |i|
      cols.map do |j|
        (rand(2) == 0) ? true : false
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

  def fate(i, j) : Bool # True = Live, False = Dead
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
