
module SDL
  class Version
    def initialize(@version)
    end

    def to_s
      "#{@version.value.major}.#{@version.value.minor}.#{@version.value.patch}"
    end
  end

  def self.version
    Version.new(LibSDL.version)
  end
end
