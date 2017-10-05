# frozen_string_literal: true

module GhostPictures
  Request = Struct.new(:id, :method, :path)

  class Capture
    def initialize(app)
      @id = 0
      @app = app
    end

    def call(env)
      req = build_request(env)
      Record.start(req)
      @app.call(env)
    ensure
      Record.finish(req)
    end

    private

    def build_request(env)
      @id += 1
      Request.new(@id, env['REQUEST_METHOD'].downcase.to_sym, env['PATH_INFO'])
    end
  end
end
