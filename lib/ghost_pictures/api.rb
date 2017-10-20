# frozen_string_literal: true

module GhostPictures
  module API
    MSG = 'Pass the operation include Ajax requests as block argument'

    def wait_for(path = nil, method: nil, count: 1)
      raise(ArgumentError, MSG) unless block_given?

      Record.reset!
      yield
      Timeout.timeout(Capybara.default_max_wait_time) do
        loop { break if Record.select_if(method, path).size >= count }
      end
    end

    # @see https://robots.thoughtbot.com/automatically-wait-for-ajax-with-capybara
    def wait_for_jquery_ajax
      Timeout.timeout(Capybara.default_max_wait_time) do
        loop until finished_all_ajax_requests?
      end
    end

    private

    def finished_all_ajax_requests?
      Capybara.page.evaluate_script('jQuery.active').zero?
    end
  end
end
