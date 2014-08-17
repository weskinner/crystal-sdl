
lib LibSDL_image("SDL_image")
  fun load = IMG_Load(file : UInt8*) : LibSDL::Surface*
end
