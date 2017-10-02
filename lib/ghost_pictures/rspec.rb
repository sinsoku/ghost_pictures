RSpec.configure do |config|
  config.before(:each) { GhostPictures.start }
  config.after(:each) { GhostPictures.finish }
end
