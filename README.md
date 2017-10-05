# GhostPictures

[![Gem Version](https://badge.fury.io/rb/ghost_pictures.svg)](https://badge.fury.io/rb/ghost_pictures)
[![Build Status](https://travis-ci.org/sinsoku/ghost_pictures.svg?branch=master)](https://travis-ci.org/sinsoku/ghost_pictures)

GhostPictures provides the feature to wait for Ajax requests with [Capybara](https://github.com/teamcapybara/capybara).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ghost_pictures', group: :test
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ghost_pictures

## Setup

### Rails

```rb
# config/environments/test.rb
config.middleware.use GhostPictures::Capture
```

## Examples

### Wait for a Ajax request

```rb
GhostPictures.wait_for { click_link "get data via Ajax" }
```

### Wait for matching requests

```rb
# Wait for a request with "/users"
GhostPictures.wait_for("/users") { click_link }

# Wait for a POST request with "/users"
GhostPictures.wait_for("/users", method: :post) { click_link }

# Wait for two requests
GhostPictures.wait_for(nil, count: 2) do
  2.times { click_link }
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sinsoku/ghost_pictures.
