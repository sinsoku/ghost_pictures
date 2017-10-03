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

Add the following code to `spec/rails_helper.rb`:

```rb
RSpec.configure do |config|
  config.before(:each) { GhostPictures.reset! }
  config.after(:each) { GhostPictures.wait if GhostPictures.running? }
end
```

It will wait for Ajax requests if running requests exist after specs run.

### How to use in examples

If you want to wait for Ajax request in examples, you can use as below:

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
