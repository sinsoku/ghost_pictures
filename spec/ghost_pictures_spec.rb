require "spec_helper"

RSpec.describe GhostPictures do
  describe ".configure" do
    it "should change settings" do
      GhostPictures.configure do |config|
        config.timeout = 10
      end
      expect(GhostPictures.config.timeout).to eq 10
    end
  end

  describe ".wait" do
    def stub_loop(*procs)
      allow(GhostPictures).to receive(:loop) do |&original|
        loop do
          procs.shift.call unless procs.empty?
          original.call
        end
      end
    end

    before { GhostPictures.reset! }

    context "running requests are empty" do
      before do
        stub_loop(
          -> { },
          -> { GhostPictures.start(1) },
          -> { GhostPictures.finish(1) }
        )
      end

      it "wait a new request, and wait a response" do
        GhostPictures.wait
        expect(GhostPictures).not_to be_running
      end
    end

    context "running requests exists" do
      before do
        stub_loop(
          -> { GhostPictures.start(1) },
          -> { GhostPictures.finish(1) }
        )
      end

      it "wait a response" do
        GhostPictures.wait
        expect(GhostPictures).not_to be_running
      end
    end

    context "pass the block argument" do
      before do
        @clicked = false
        stub_loop(
          -> { raise unless @clicked },
          -> { GhostPictures.start(1) },
          -> { GhostPictures.finish(1) }
        )
      end

      it "call the process before waiting response" do
        GhostPictures.wait { @clicked = true }

        expect(@clicked).to be true
        expect(GhostPictures).not_to be_running
      end
    end

    context "waiting for a long time" do
      before do
        GhostPictures.config.timeout = 0.1
        stub_loop(
          -> { GhostPictures.start(1) }
        )
      end

      it "raise Timeout::Error" do
        expect { GhostPictures.wait }.to raise_error Timeout::Error
      end
    end
  end
end
