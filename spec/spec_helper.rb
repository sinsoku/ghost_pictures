require "bundler/setup"
require "ghost_pictures"
require "capybara/rspec"
require "selenium-webdriver"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

require 'fake_app'
Capybara.app = GhostPictures::Capture.new(FakeApp)
Capybara.register_driver :chrome_headless do |app|
  caps = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w[--headless] }
  )
  Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: caps)
end
Capybara.default_driver = :chrome_headless
