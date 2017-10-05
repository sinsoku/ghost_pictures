# frozen_string_literal: true

require 'spec_helper'

RSpec.describe GhostPictures::Record do
  let(:get_root) { GhostPictures::Request.new(1, :get, '/') }

  before { described_class.reset! }

  describe '#start' do
    before { described_class.start(get_root) }
    it { is_expected.to be_running }
  end

  describe '#finish' do
    before do
      described_class.start(get_root)
      described_class.finish(get_root)
    end
    it { is_expected.not_to be_running }
  end

  describe 'select_if' do
    let(:get_users) { GhostPictures::Request.new(2, :get, '/users') }
    let(:post_users) { GhostPictures::Request.new(3, :post, '/users') }

    before do
      [get_root, get_users, post_users].each do |req|
        described_class.start(req)
        described_class.finish(req)
      end
    end

    context 'not specify conditions' do
      subject { described_class.select_if(nil, nil) }
      it 'should return all requests' do
        is_expected.to contain_exactly(get_root, get_users, post_users)
      end
    end

    context 'specify the GET method' do
      subject { described_class.select_if(:get, nil) }
      it 'should return GET requests' do
        is_expected.to contain_exactly(get_root, get_users)
      end
    end

    context "specify the '/users' path" do
      subject { described_class.select_if(nil, '/users') }
      it 'should return GET/POST requests' do
        is_expected.to contain_exactly(get_users, post_users)
      end
    end

    context 'specify both conditions' do
      subject { described_class.select_if(:get, '/users') }
      it 'should return a match request' do
        is_expected.to contain_exactly(get_users)
      end
    end
  end
end
