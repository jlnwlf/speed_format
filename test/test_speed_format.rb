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

require(File.expand_path('../lib/speed_format', File.dirname(__FILE__)))
require "test/unit"

class TestSpeedFormat < Test::Unit::TestCase

  def test_simple
    SpeedFormat::format 123
  end

  def test_float
    SpeedFormat::format 123.123
  end

  def test_prefix
    SpeedFormat::format 123.123, :k
  end

  def test_string
    SpeedFormat::format "12312.32"
    SpeedFormat::format "12312"
  end

  def test_wrong_prefix
    assert_raise(ArgumentError) do
      SpeedFormat::format "12345", :l
    end
  end

  def test_simple_values
    values = [
      [[1], [1, nil]],
      [[2], [2, nil]],
      [[3, :M], [3, :M]],
      [[4, :G], [4, :G]],
      [["5.000", :T], [5, :T]],
      [[1000, :M], [1, :G]],
      [[123000], [123, :k]],
      [["123000"], [123, :k]],
      [[123.12], [123.12, nil]],
      [["0.3", :k], [300, nil]],
      [[0.0004, :M], [400, nil]],
      [[0.00000000054, :T], [540, nil]],
      [["123456789", :E],[123456789, :E]],
      [["123456789.1723618276123", :E],[123456789172361827612300, :k]],
      [["123000000000000", nil],[123, :T]],
      [["-123456789", nil],[123456789, nil]],
      [["123000000000000000000000", nil],[123000, :E]],
      [[123000000000000000000000000000000000000000000, :E],[123000000000000000000000000000000000000000000, :E]],
      [[0.000000000000000000000000000000000000132],[0.000000000000000000000000000000000000132, nil]],
      [[12.102, :M],[12102, :k]]
    ]
    values.each do |input, output|
      assert_equal(output, SpeedFormat::format(*input))
      assert_equal(output.join(" ") + "bit/s", SpeedFormat::format_string(*input))
    end
  end

  def test_zeroes
    values = [
      [0,0],
      ["0",0],
      ["0.0",0],
    ]
    values.each do |input, output|
      SpeedFormat::units.each do |prefix|
        assert_equal([output, nil], SpeedFormat::format(input, prefix))
        assert_equal([output, nil].join(" ") + "bit/s", SpeedFormat::format_string(input, prefix))
      end
    end
  end

  def test_units

    values = [
      [1,1],
      ["1",1],
      ["1.0",1],
      [2,2],
      ["2",2],
      ["2.0",2],
      [3,3],
      ["3",3],
      ["3.0",3],
    ]
    values.each do |input, output|
      SpeedFormat::units.each do |prefix|
        assert_equal([output, prefix], SpeedFormat::format(input, prefix))
        assert_equal([output, prefix].join(" ") + "bit/s", SpeedFormat::format_string(input, prefix))
      end
    end
  end
end
