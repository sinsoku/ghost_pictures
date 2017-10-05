# frozen_string_literal: true

require 'timeout'
require 'ghost_pictures/capture'
require 'ghost_pictures/record'
require 'ghost_pictures/version'

module GhostPictures
  class << self
    def wait(path = nil, method: nil, count: 1)
      raise('error') unless block_given?

      Record.reset!
      yield
      Timeout.timeout(Capybara.default_max_wait_time) do
        loop { break if Record.select_if(method, path).size >= count }
      end
    end
  end
end
