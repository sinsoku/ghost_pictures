require "timeout"
require "ghost_pictures/config"
require "ghost_pictures/version"
require "ghost_pictures/rails" if defined?(Rails)

module GhostPictures
  class << self
    def config
      Config.instance
    end

    def configure(&block)
      yield(config)
    end

    def finish(request)
      requests.delete(request)
    end

    def reset!
      @requests = []
    end

    def running?
      !requests.empty?
    end

    def start(request)
      requests << request
    end

    def wait
      last_request = requests.last
      yield if block_given?
      wait_until { new_request?(last_request) }
      wait_until { requests.empty? }
    end

    private

    def new_request?(last_request)
      last_request.nil? ? running? : last_request != requests.last
    end

    def requests
      @requests ||= reset!
    end

    def wait_until(&block)
      Timeout.timeout(config.timeout) do
        loop { break if block.call }
      end
    end
  end
end
