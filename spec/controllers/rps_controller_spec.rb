require 'rails_helper'

RSpec.describe RpsController, type: :controller do
  describe "GET #start" do
    it "renders the start template" do
      get :start
      expect(response).to render_template(:start)
    end
  end

  describe "GET #throw" do
    let(:user_bet) { "rock" }
    let(:server_bet) { "paper" }
    let(:result) { "lose" }

    before do
      allow_any_instance_of(RpsService).to receive(:generated_bet).and_return(server_bet)
      allow_any_instance_of(RpsService).to receive(:result).and_return(result)
      get :throw, params: { id: user_bet }
    end

    it "assigns @your_bet" do
      expect(assigns(:your_bet)).to eq(user_bet)
    end

    it "assigns @server_bet" do
      expect(assigns(:server_bet)).to eq(server_bet)
    end

    it "assigns @result" do
      expect(assigns(:result)).to eq(result)
    end

    it "renders the throw template" do
      expect(response).to render_template(:throw)
    end
  end
end
