require "sdl/version"
require "sdl/rect"
require "sdl/image"
require "sdl/surface"
require "sdl/display"
require "sdl/color"
require "sdl/event"
require "sdl/point"
require "sdl/vector"
require "sdl_main"
require "sdl_image"

module SDL
  def self.init(flags = LibSDL::INIT_EVERYTHING)
    if LibSDL.init(flags) != 0
      raise "Can't initialize SDL: #{error}"
    end
  end

  def self.set_video_mode(width, height, bpp, flags)
    if width && height
      surface = LibSDL.set_video_mode(width, height, bpp, flags)
      if surface.nil?
        raise "Can't set SDL video mode: #{error}"
      end
    else
      raise "Can't set SDL video mode without width & height!"
    end
    Surface.new(surface, width, height, bpp)
  end

  def self.create_rgb_surface(width, height)
    surface = LibSDL.create_rgb_surface(0.to_u32, width, height, 32, 0.to_u32, 0.to_u32, 0.to_u32, 0.to_u32).value
    if surface.nil?
      raise "Can't create SDL surface: #{error}"
    end
    Surface.new(surface, width, height, 32)
  end

  def self.show_cursor
    LibSDL.show_cursor LibSDL::ENABLE
  end

  def self.hide_cursor
    LibSDL.show_cursor LibSDL::DISABLE
  end

  def self.error
    String.new LibSDL.get_error
  end

  def self.ticks
    LibSDL.get_ticks
  end

  def self.quit
    LibSDL.quit
  end

  # Poll a single event from the queue
  def self.poll_event
  end

  # Poll all events on the queue
  def self.poll_events
    while LibSDL.poll_event(out event) == 1
      yield SDL::Event.new(event)
    end
  end
end
