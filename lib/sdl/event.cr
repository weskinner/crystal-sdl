module SDL
  class Event
    def initialize(@event)
    end

    def key
      @event.key
    end

    def quit?
      @event.type == LibSDL::QUIT
    end

    def keydown?
      @event.type == LibSDL::KEYDOWN
    end

    def keyup?
      @event.type == LibSDL::KEYUP
    end

    def arrow_right?
      @event.key.key_sym.sym == LibSDL::Key::RIGHT
    end

    def arrow_left?
      @event.key.key_sym.sym == LibSDL::Key::LEFT
    end
  end
end
