# Guard::Sprockets [![Build Status](https://secure.travis-ci.org/guard/guard-sprockets.png?branch=master)](http://travis-ci.org/guard/guard-sprockets)

Sprockets guard automatically packages your JavaScript files together when your source files are saved.

* Compatible with Sprockets 2.x (for Sprockets 1.x compatibility, please use Guard::Sprockets 0.1.4 or the `sprockets_1` branch).
* Tested against Ruby 1.8.7, 1.9.2, 1.9.3, REE and the latest versions of JRuby & Rubinius.

## Install

Please be sure to have [Guard](https://github.com/guard/guard) installed before continue.

Install the gem:

```
$ gem install guard-sprockets
```

Add it to your Gemfile (inside the `:tools` group for instance):

```ruby
group :tools do
  gem 'guard-sprockets'
end
```

Add guard definition to your Guardfile by running this command:

```
$ guard init sprockets
```

## Usage

Please read [Guard usage doc](https://github.com/guard/guard#readme)

## Guardfile

Guard::Sprockets can be adapted to all kind of projects.

### Typical Rails 3 app (default generated Guardfile)

``` ruby
guard 'sprockets', :destination => 'public/javascripts', :asset_paths => ['/app/assets/javascripts'] do
  watch 'app/assets/javascripts/application.js'
end
```

Please read [Guard doc](https://github.com/guard/guard#readme) for more information about the Guardfile DSL.

## Options

``` ruby
:destination => 'public/js'          # change the destination folder in which the compiled assets are saved, default: 'public/javascripts'
:asset_paths => 'app/js'             # add a directory (or on array of directories) to Sprockets' environment's load path, default: ['app/assets/javascripts']
:asset_paths => ['app/js', 'lib/js'] # asset_paths can be a String or an Array
:minify      => true                 # minify the JavaScript files content using Uglifier, default: false
                                     # be sure to add: "gem 'uglifier'" in your Gemfile
:root_file   => 'app/js/app.js'      # if set, only this file will be compiled, default: nil
:root_file   => ['one.js', 'two.js'] # root_file can be a String or an Array
```

## License
(The MIT License)

Copyright (c) 2011-2012 Aaron Cruz

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
