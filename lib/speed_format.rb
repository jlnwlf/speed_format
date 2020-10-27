# Transform unreadable speed to beautiful ones with the right prefix
# Copyright (C) 2016 Julien Wolflisberg

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

require 'bigdecimal'

class SpeedFormat
  @@units = [nil, :k, :M, :G, :T, :P, :E]

  # Get *bps* in *unit* and format it, if *bytes* is provided, the output is in bytes instead of bits
  def self.format(bps, unit=nil, bytes=nil)
      if not @@units.include?(unit)
        raise ArgumentError, "Not a valid prefix"
      end
      bps = BigDecimal(bps.to_s).abs
      if bytes == :bytes
        bps /= 8
      end
      index = @@units.index(unit)
      d = bps % 1 != 0.0 ? 1 : -1 # If there's right side digits, should move the comma right, otherwise left
      if bps != 0.0
        if d == 1 # Move to the right (non-integers)
          while (bps % 1 != 0.0) and (index-d >= 0) and (index-d < @@units.length)
              bps *= 10.0**(d*3)
              index -= d
          end
        else # Move to the left
          next_v = (bps*10.0**(d*3)) # Calculating the next
          while (next_v % 1 == 0.0) and (index-d >= 0) and (index-d < @@units.length)
              bps *= 10.0**(d*3)
              index -= d
              next_v = bps*10.0**(d*3)
          end
        end
      else
        index = 0
      end
      bps = bps.to_s("F")
      return bps[-2,2] == ".0" ? bps[0..-3].to_i : Float(bps), @@units[index]
  end

  def self.format_string(*args)
    out = self.format(*args)
    out[0] = out[0] % 1 == 0.0 ? out[0].to_i : out[0]
    suffix = args.include?(:bytes) ? "B/s" : "bit/s"
    out.join(" ") + suffix
  end

  def self.units
    @@units
  end
end
