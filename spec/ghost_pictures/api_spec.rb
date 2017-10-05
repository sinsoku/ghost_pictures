# frozen_string_literal: true

require 'spec_helper'

RSpec.describe GhostPictures::API do
  describe '#wait_for' do
    context 'call without block' do
      it 'should raise ArgumentError with message' do
        expect { GhostPictures.wait_for }.to raise_error(ArgumentError, /^Pass the operation/)
      end
    end
  end
end
