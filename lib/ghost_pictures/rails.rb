module GhostPictures
  module Rails
    def self.included(base)
      base.class_eval do
        before_action { GhostPictures.start(request) }
        after_action { GhostPictures.finish(request) }
      end
    end
  end
end

ActionController::Base.include(GhostPictures::Rails)
