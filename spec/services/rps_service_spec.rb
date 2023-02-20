require 'rails_helper'

RSpec.describe RpsService do
  let(:user_bet) { "rock" }
  let(:service) { described_class.new(user_bet: user_bet) }

  describe "#result" do
    context "when user wins" do
      it "returns :user" do
        allow(service).to receive(:generated_bet).and_return(:scissors)
        expect(service.result).to eq(:user)
      end
    end

    context "when server wins" do
      it "returns :server" do
        allow(service).to receive(:generated_bet).and_return(:paper)
        expect(service.result).to eq(:server)
      end
    end

    context "when tie" do
      it "returns :tie" do
        allow(service).to receive(:generated_bet).and_return(:rock)
        expect(service.result).to eq(:tie)
      end
    end
  end

  describe "#generated_bet" do
    it "returns a random bet from [:rock, :paper, :scissors]" do
      expect([:rock, :paper, :scissors]).to include(service.generated_bet)
    end

    it "memoizes the result" do
      expect(service.generated_bet).to equal(service.generated_bet)
    end
  end
end