module SDL
  class Keys
    def initialize(@state)
    end

    def arrow_up?
      @state[LibSDL::Key::UP] == 1
    end

    def arrow_down?
      @state[LibSDL::Key::DOWN] == 1
    end

    def arrow_left?
      @state[LibSDL::Key::LEFT] == 1
    end

    def arrow_right?
      @state[LibSDL::Key::RIGHT] == 1
    end
  end
end
