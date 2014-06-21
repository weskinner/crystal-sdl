
module SDL
  class Event
    def initialize(@event)
    end

    def quit?
      @event.type == LibSDL::QUIT
    end

    def keydown?
      @event.type == LibSDL::KEYDOWN
    end
  end
end
