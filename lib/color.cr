
module SDL
  class Color
    def self.from_hex(hex_string)
      red   = parse_hex(hex_string[0,2])
      green = parse_hex(hex_string[2,2])
      blue  = parse_hex(hex_string[4,2])
    end

    def hex_value(c)
      if ('0'..'9').include?(c)
        c.to_i
      else
        case c.downcase
        when 'a'
          10
        when 'b'
          11
        when 'c'
          12
        when 'd'
          13
        when 'e'
          14
        when 'f'
          15
        else
          raise "Cannot handle hex value for #{c}!"
        end
      end
    end

    def self.parse_hex(string)
      hex_value(string[0]) + (16 * hex_value(string[1]))
    end

    def self.struct(r, g, b)
      c = LibSDL::Color.new
      c.r = r.to_u8
      c.g = r.to_u8
      c.b = r.to_u8
      c
    end

    def self.white
      struct(255, 255, 255)
    end
  end
end
