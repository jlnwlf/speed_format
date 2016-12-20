# speed_format: Bit rate for humans

[![Build Status](https://travis-ci.org/julienwolflisberg/speed_format.svg?branch=master)](https://travis-ci.org/julienwolflisberg/speed_format)
[![Coverage Status](https://coveralls.io/repos/github/julienwolflisberg/speed_format/badge.svg?branch=master)](https://coveralls.io/github/julienwolflisberg/speed_format?branch=master)

- 💎 (MRI/JRuby) >= 1.9
- Pure 💎, no dependencies.

## Install

```shell
$ gem install speed_format
```

or used with Bundler:

```ruby
gem 'speed_format'
```

or use the edge version from GitHub:

```ruby
gem "speed_format", :git => "https://github.com/julienwolflisberg/speed_format.git"
```

## Usage

```ruby
require 'speed_format'

# Format to string
SpeedFormat::format_string("123")
 => "123 bit/s"
SpeedFormat::format_string("123000")
 => "123 kbit/s"
SpeedFormat::format_string("123000000")
 => "123 Mbit/s"
SpeedFormat::format_string("123000000000")
 => "123 Gbit/s"

# Or use prefixes...
SpeedFormat::format_string("0.0004", :M)
 => "400 bit/s"

# Otherwise get raw conversion...
SpeedFormat::format("123000000000")
 => [123, :G]
```

## License

```
Copyright (C) 2016 Julien Wolflisberg

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
```
