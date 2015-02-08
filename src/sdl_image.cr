@[Link("SDL_image")]
lib LibSDL_image
  fun load = IMG_Load(file : UInt8*) : LibSDL::Surface*
end
