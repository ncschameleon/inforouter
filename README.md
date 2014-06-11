# The infoRouter Ruby Gem

[![Gem Version](http://img.shields.io/gem/v/inforouter)][gem]
[![Build Status](http://img.shields.io/travis/ncssoftware/inforouter.svg)][travis]

[gem]: https://rubygems.org/gems/inforouter
[travis]: https://travis-ci.org/ncssoftware/inforouter

A Ruby interface to the infoRouter SOAP API

## Installation

Add this line to your application's Gemfile:

    gem 'inforouter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install inforouter

## Usage

Configure your environment. For example, create an initializer in Rails in <tt>config/initializers/inforouter.rb</tt>.

    Inforouter.configure do |config|
      config.host     = 'your_inforouter_host'
      config.username = 'your_inforouter_username'
      config.password = 'your_inforouter_password'
    end

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

Copyright (c) 2014 NCS Software.
See [LICENSE][] for further details.

[license]: LICENSE.md
