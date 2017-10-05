# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'GhostPictures', type: :feature do
  MESSAGE = 'The example finished before the request complete'

  before(:context) { @running = [] }
  before do |example|
    @running << example.object_id

    m = FakeApp.method(:call)
    allow(FakeApp).to receive(:call) do |env|
      m.call(env).tap do
        raise(MESSAGE) unless @running.include?(example.object_id)
      end
    end
    visit '/'
  end
  after { |example| @running.delete(example.object_id) }

  def call_ajax(path: '/js', method: :get, delay: 0.1)
    execute_script("callAjax('#{method.to_s.upcase}', '#{path}', #{delay});")
  end

  it 'should wait a request after call block arg' do
    GhostPictures.wait('/js') { call_ajax }
  end

  it 'should wait requests' do
    GhostPictures.wait('/js', count: 2) do
      call_ajax
      call_ajax
    end
  end

  it 'should wait a post request' do
    GhostPictures.wait('/js', method: :post) { call_ajax(method: :post) }
  end
end
