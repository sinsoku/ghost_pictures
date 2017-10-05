# frozen_string_literal: true

module GhostPictures
  module Record
    class << self
      def reset!
        @started = []
        @finished = []
      end

      def start(request)
        started << request
      end

      def finish(request)
        finished << request
      end

      def select_if(method, path)
        finished.select do |req|
          (method.nil? || req.method == method) &&
            (path.nil? || req.path == path)
        end
      end

      def running?
        !running_requests.empty?
      end

      private

      def running_requests
        started - finished
      end

      def started
        @started ||= []
      end

      def finished
        @finished ||= []
      end
    end
  end
end
