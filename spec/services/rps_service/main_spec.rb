require 'rails_helper'

RSpec.describe RpsService::Main do
  let(:user_bet) { "rock" }
  let(:service) { described_class.new(user_bet: user_bet) }

  describe "#result" do
    context "when user wins" do
      described_class::RULE_SET.each do |winning_bet, loosing_bets|
        loosing_bets.each do |loosing_bet|
          let(:user_bet) { winning_bet }
          before do
            allow(service).to receive(:generated_bet).and_return(loosing_bet)
          end

          it "returns :user for #{winning_bet} against #{loosing_bet}" do
            expect(service.result).to eq(:user)
          end
        end
      end
    end

    context "when server wins" do
      described_class::RULE_SET.each do |winning_bet, loosing_bets|
        loosing_bets.each do |loosing_bet|
          let(:user_bet) { loosing_bet }
          before do
            allow(service).to receive(:generated_bet).and_return(winning_bet)
          end

          it "returns :server for #{winning_bet} against #{loosing_bet}" do
            expect(service.result).to eq(:server)
          end
        end
      end
    end


    context "when it is a tie" do
      described_class::RULE_SET.each do |winning_bet, _|
        let(:user_bet) { winning_bet }
        before do
          allow(service).to receive(:generated_bet).and_return(winning_bet)
        end

        it "returns tie for #{winning_bet}" do
          expect(service.result).to eq(:tie)
        end
      end
    end
  end
end