
lib LibSDL("SDL")
  INIT_TIMER       = 0x00000001_u32
  INIT_AUDIO       = 0x00000010_u32
  INIT_VIDEO       = 0x00000020_u32
  INIT_CDROM       = 0x00000100_u32
  INIT_JOYSTICK    = 0x00000200_u32
  INIT_NOPARACHUTE = 0x00100000_u32
  INIT_EVENTTHREAD = 0x01000000_u32
  INIT_EVERYTHING  = 0x0000FFFF_u32

  SWSURFACE = 0x00000000_u32
  HWSURFACE = 0x00000001_u32
  ASYNCBLIT = 0x00000004_u32

  ANYFORMAT  = 0x10000000_u32
  HWPALETTE  = 0x20000000_u32
  DOUBLEBUF  = 0x40000000_u32
  FULLSCREEN = 0x80000000_u32
  OPENGL     = 0x00000002_u32
  OPENGLBLIT = 0x0000000A_u32
  RESIZABLE  = 0x00000010_u32
  NOFRAME    = 0x00000020_u32

  NOEVENT         =  0_u8
  ACTIVEEVENT     =  1_u8
  KEYDOWN         =  2_u8
  KEYUP           =  3_u8
  MOUSEMOTION     =  4_u8
  MOUSEBUTTONDOWN =  5_u8
  MOUSEBUTTONUP   =  6_u8
  JOYAXISMOTION   =  7_u8
  JOYBALLMOTION   =  8_u8
  JOYHATMOTION    =  9_u8
  JOYBUTTONDOWN   = 10_u8
  JOYBUTTONUP     = 11_u8
  QUIT            = 12_u8
  SYSWMEVENT      = 13_u8
  EVENT_RESERVEDA = 14_u8
  EVENT_RESERVEDB = 15_u8
  VIDEORESIZE     = 16_u8
  VIDEOEXPOSE     = 17_u8
  EVENT_RESERVED2 = 18_u8
  EVENT_RESERVED3 = 19_u8
  EVENT_RESERVED4 = 20_u8
  EVENT_RESERVED5 = 21_u8
  EVENT_RESERVED6 = 22_u8
  EVENT_RESERVED7 = 23_u8
  USEREVENT       = 24_u8
  NUMEVENTS       = 32_u8

  HWACCEL     = 0x00000100_u32
  SRCCOLORKEY = 0x00001000_u32
  RLEACCELOK  = 0x00002000_u32
  RLEACCEL    = 0x00004000_u32
  SRCALPHA    = 0x00010000_u32
  PREALLOC    = 0x01000000_u32

  DISABLE = 0
  ENABLE = 1

  struct Color
    r, g, b, unused : UInt8
  end

  struct Rect
    x, y : Int16
    w, h : UInt16
  end

  struct Surface
    flags : UInt32
    format : Void* #TODO
    w, h : Int32
    pitch : UInt16
    pixels : Void*
    #TODO
  end

  struct Version
    major : UInt8
    minor : UInt8
    patch : UInt8
  end

  struct KeySym
    scan_code : UInt8
    sym : UInt32
    #TODO
  end

  struct KeyboardEvent
    type : UInt8
    which : UInt8
    state : UInt8
    key_sym : KeySym
  end

  union Event
    type : UInt8
    key : KeyboardEvent
  end


  fun init = SDL_Init(flags : UInt32) : Int32
  fun get_error = SDL_GetError() : UInt8*
  fun quit = SDL_Quit() : Void
  fun set_video_mode = SDL_SetVideoMode(width : Int32, height : Int32, bpp : Int32, flags : UInt32) : Surface*
  fun delay = SDL_Delay(ms : UInt32) : Void
  fun poll_event = SDL_PollEvent(event : Event*) : Int32
  fun wait_event = SDL_WaitEvent(event : Event*) : Int32
  fun lock_surface = SDL_LockSurface(surface : Surface*) : Int32
  fun unlock_surface = SDL_UnlockSurface(surface : Surface*) : Void
  fun update_rect = SDL_UpdateRect(screen : Surface*, x : Int32, y : Int32, w : Int32, h : Int32) : Void
  fun show_cursor = SDL_ShowCursor(toggle : Int32) : Int32
  fun get_ticks = SDL_GetTicks : UInt32
  fun flip = SDL_Flip(screen : Surface*) : Int32

  #############
  # My Stuff! #
  #############
  fun blit_surface = SDL_UpperBlit(src : Surface*, srcrect : Rect*, dst : Surface*, dstrect : Rect*) : Int32

  fun create_rgb_surface = SDL_CreateRGBSurface(flags : UInt32, width : Int32, height : Int32, depth : Int32, rmask : UInt32, gmask : UInt32, bmask : UInt32, amask : UInt32) : Surface*
  fun version      = SDL_Linked_Version() : Version*
end


lib SDLMain("SDLMain")
end

ifdef darwin
  lib LibCocoa("`echo \"-framework Cocoa\"`")
  end
end

undef main

redefine_main("SDL_main") do |main|
  {{main}}
end


lib LibSDL_image("SDL_image")
  fun get_error = IMG_GetError() : UInt8*
  fun load = IMG_Load(file : UInt8*) : LibSDL::Surface*
end

require "rect"

module SDL
  def self.version
    Version.new(LibSDL.version)
  end

  class Image
    def self.error
      String.new LibSDL_image.get_error
    end

    property :image
    property :file_name

    def initialize(@file_name)
      @image = LibSDL_image.load(@file_name)
    end

    def width
      @image.value.w
    end

    def height
      @image.value.h
    end

    def to_s
      "Surface: file_name=#{@file_name}, width=#{width}, height=#{height}"
    end

    def draw_onto(surface : SDL::Surface, point : Point)
      image = Surface.new(@image, @image.value.w, @image.value.h, 32)
      #surface.lock

      surface.blit(@image, point)

      # LibSDL.blit_surface @image, source.pointer, surface.surface, destination.pointer

      #surface.unlock
      surface.flip

      # LibSDL.blit_surface
      # puts "done blitting surface"
    end
  end
end


module SDL
  def self.init(flags = LibSDL::INIT_EVERYTHING)
    if LibSDL.init(flags) != 0
      raise "Can't initialize SDL: #{error}"
    end
  end

  def self.set_video_mode(width, height, bpp, flags)
    puts "Calling LibSDL.set_video_mode"
    surface = LibSDL.set_video_mode(width, height, bpp, flags)
    puts "Checking if surface is nil"
    if surface.nil?
      raise "Can't set SDL video mode: #{error}"
    end
    Surface.new(surface, width, height, bpp)
  end

  def self.create_rgb_surface(width, height)
    surface = LibSDL.create_rgb_surface(0.to_u32, width, height, 32, 0.to_u32, 0.to_u32, 0.to_u32, 0.to_u32)
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

  def self.poll_events
    while LibSDL.poll_event(out event) == 1
      yield event
    end
  end
end

require "surface"
