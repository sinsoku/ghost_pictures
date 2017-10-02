# GhostPictures

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

## Usage

GhostPictures integrates to Rails and RSpec automatically, so wait for Ajax requests after specs run.

If you wait for Ajax request manually, you can use as below:

```rb
click_link "get data via Ajax"
GhostPictures.wait
```

Or use it with the block argument:

```rb
GhostPictures.wait { click_link "get data via Ajax" }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sinsoku/ghost_pictures.
