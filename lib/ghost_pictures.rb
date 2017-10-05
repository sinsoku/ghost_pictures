# frozen_string_literal: true

require 'timeout'
require 'ghost_pictures/capture'
require 'ghost_pictures/record'
require 'ghost_pictures/version'

module GhostPictures
  class << self
    def reset!
      Record.reset!
    end

    def wait(path = nil, method: nil, count: 1)
      yield if block_given?

      Timeout.timeout(Capybara.default_max_wait_time) do
        loop { break if Record.select_if(method, path).size >= count }
      end
    end

    def running?
      Record.running?
    end
  end
end
