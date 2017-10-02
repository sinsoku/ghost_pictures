module GhostPictures
  module Rails
    def self.included(base)
      base.class_eval do
        before_action { GhostPictures.requests << request }
        after_action { GhostPictures.requests.shift }
      end
    end
  end
end

ActionController::Base.include(GhostPictures::Rails)
