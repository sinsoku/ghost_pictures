# frozen_string_literal: true

require 'spec_helper'

RSpec.describe GhostPictures::Capture do
  let(:app) { ->(_env) { [200, { 'Content-Type' => 'text/plain' }, ['Hello']] } }
  let(:env) { { 'REQUEST_METHOD' => 'GET', 'PATH_INFO' => '/' } }

  before { GhostPictures::Record.reset! }

  describe '#call' do
    let(:wrapped) { described_class.new(app) }

    it 'should record requests' do
      wrapped.call(env)
      wrapped.call(env)

      requests = GhostPictures::Record.select_if(nil, nil)
      expect(requests.size).to eq 2

      expect(requests[0]).to have_attributes id: 1, method: :get, path: '/'
      expect(requests[1]).to have_attributes id: 2, method: :get, path: '/'
    end
  end
end
