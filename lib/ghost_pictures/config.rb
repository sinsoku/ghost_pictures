require 'singleton'

module GhostPictures
  class Config
    include Singleton

    attr_accessor :timeout

    def initialize
      @timeout = defined?(Capybara) ? Capybara.default_max_wait_time : 30
    end
  end
end
