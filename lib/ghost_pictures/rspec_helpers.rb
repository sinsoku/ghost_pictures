# frozen_string_literal: true

module GhostPictures
  module RSpecHelpers
    def wait_for_ajax(*args, &block)
      GhostPictures.wait_for(*args, &block)
    end

    def wait_for_jquery_ajax
      GhostPictures.wait_for_jquery_ajax
    end
  end
end
