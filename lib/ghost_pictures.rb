require "timeout"
require "ghost_pictures/config"
require "ghost_pictures/version"
require "ghost_pictures/rails" if defined?(Rails)
require "ghost_pictures/rspec" if defined?(RSpec)

module GhostPictures
  class << self
    def config
      Config.instance
    end

    def configure(&block)
      yield(config)
    end

    def requests
      @requests ||= []
    end

    def start
      @requests = []
    end

    def finish
      # TODO: Add a feature to select action as below
      #       raise error, print warnings, wait for Ajax automatically
      wait if running?
    end

    def wait
      wait_new_request { yield if block_given? }
      wait_proc { requests.empty? }
    end

    private

    def running?
      !requests.empty?
    end

    def wait_new_request(&block)
      last_request = requests.last
      block.call
      wait_proc { last_request.nil? ? running? : last_request != requests.last }
    end

    def wait_proc(&block)
      Timeout.timeout(config.timeout) do
        loop { break if block.call }
      end
    end
  end
end
