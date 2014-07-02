require "../lib/sdl"


class TopDown
  def initialize(@width = 640, @height = 480)
    SDL.init
    SDL.show_cursor

    beachball_file = "#{__DIR__}/beach_ball.png"
    @beachball     = SDL::Image.new(beachball_file)

    if @beachball.nil?
      puts "Couldn't load beachball!"
      puts SDL.error
    end
  end
end


TopDown.new.main
