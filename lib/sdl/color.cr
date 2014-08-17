module SDL
  class Color
    def self.from_hex(hex_string)
      red   = parse_hex(hex_string[0,2])
      green = parse_hex(hex_string[2,2])
      blue  = parse_hex(hex_string[4,2])
      SDL::Color.from_struct(red, green, blue)
    end

    def self.hex_value(c)
      if ("0".."9").includes?(c)
        c.to_i
      else
        case c.downcase
        when "a"
          10
        when "b"
          11
        when "c"
          12
        when "d"
          13
        when "e"
          14
        when "f"
          15
        else
          raise "Cannot handle hex value for #{c}!"
        end
      end
    end

    def self.parse_hex(string)
      values = string.split("")
      hex_value(values[0]) + (16 * hex_value(values[1]))
    end

    def self.from_struct(r, g, b)
      c = LibSDL::Color.new
      c.r = r.to_u8
      c.g = g.to_u8
      c.b = b.to_u8
      c
    end

    def self.blue
      struct(0, 0, 255)
    end

    def self.white
      struct(255, 255, 255)
    end

    def self.black
      from_struct(0, 0, 0)
    end
  end
end
