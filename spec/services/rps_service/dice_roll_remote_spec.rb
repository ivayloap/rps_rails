require 'rails_helper'

RSpec.describe RpsService::DiceRollRemote do
  let(:dice_roll_remote) { described_class.new }
  let(:uri) { URI(described_class::FOUR_WAY_DICE_URL) }

  describe '#call' do
    context 'when available' do
      before do
        allow(dice_roll_remote).to receive(:available?).and_return(true)
      end

      it 'returns one of :rock, :paper, or :scissors' do
        expect(dice_roll_remote.call).to be_in([:rock, :paper, :scissors])
      end
    end

    context 'when not available' do
      before do
        allow(dice_roll_remote).to receive(:available?).and_return(false)
      end

      it 'returns nil' do
        expect(dice_roll_remote.call).to be_nil
      end
    end
  end

  describe "#call" do
    it 'returns nil unless available' do
      allow(dice_roll_remote).to receive(:available?).and_return(false)
      expect(dice_roll_remote.call).to be_nil
    end

    %w(rock paper scissors hammer).each_with_index do |item, index|
      it "returns proper RPS value for #{item}" do
        allow(dice_roll_remote).to receive(:to_json).and_return({'result' => index + 1})
        expect(dice_roll_remote.call).to eq item.to_sym
      end
    end
  end

  describe '#available?' do
    context 'when response is successful' do
      before do
        allow(Net::HTTP).to receive(:get_response).with(uri).and_return(Net::HTTPOK.new(1.0, "200", "OK"))
      end

      it 'returns true' do
        expect(dice_roll_remote.available?).to be true
      end
    end

    context 'when response is not successful' do
      before do
        allow(Net::HTTP).to receive(:get_response).with(uri).and_return(Net::HTTPNotFound.new(1.0, "404", "Not Found"))
      end

      it 'returns false' do
        expect(dice_roll_remote.available?).to be false
      end
    end
  end

end