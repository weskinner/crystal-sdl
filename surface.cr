class SDL::Surface
  getter :surface
  getter :width
  getter :height
  getter :bpp

  def initialize(@surface, @width, @height, @bpp)
  end

  def each_row
    w = width - 1
    (0..w).each do |i|
      yield i
    end
  end

  def each_col
    h = height - 1
    (0..h).each do |j|
      yield j
    end
  end

  def lock
    LibSDL.lock_surface @surface
  end

  def unlock
    LibSDL.unlock_surface @surface
  end

  def update_rect(x, y, w, h)
    LibSDL.update_rect @surface, x, y, w, h
  end

  def flip
    LibSDL.flip @surface
  end

  def fill(color)
    fill(color, @surface.rect)
  end

  def fill(color, rect)

  end

  def blit(image, point)
    start_rect = SDL::Rect.from(image)
    end_rect   = start_rect + point
    LibSDL.blit_surface image, start_rect.pointer, @surface, end_rect.pointer
  end

  def [](offset)
    (@surface.value.pixels as UInt32*)[offset].to_u32
  end

  def []=(offset, color)
    (@surface.value.pixels as UInt32*)[offset] = color.to_u32
  end

  def []=(x, y, color)
    self[y.to_i32 * @width + x.to_i32] = color
  end

  def offset(x, y)
    x.to_i32 + (y.to_i32 * @width)
  end
end
