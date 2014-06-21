require "sdl"

width = 640
height = 480

SDL.init
SDL.show_cursor

surface = SDL.set_video_mode width, height, 32, LibSDL::DOUBLEBUF | LibSDL::HWSURFACE | LibSDL::ASYNCBLIT


loop do
  SDL.poll_events do |event|
    if event.type == LibSDL::QUIT || event.type == LibSDL::KEYDOWN
      SDL.quit
      exit
    end
  end
end
