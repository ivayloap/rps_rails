require 'rails_helper'

describe RpsService::LocalGenerator do
  let (:local_generator) { described_class.new }

  describe '#call' do
    it 'logs a message to Rails logger with info level' do
       expect(Rails.logger).to receive(:info).with("Calling local generator")
       local_generator.call
    end

    it 'returns one of the three possible values randomly' do
       expect([:rock, :paper, :scissors]).to include(local_generator.call)
    end
  end
end