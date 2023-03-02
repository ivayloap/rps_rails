class RpsController < ApplicationController
  def start
  end

  def throw
    @your_bet = params[:id]
    @server_bet ||= rps_service.generated_bet.to_s
    @result ||= rps_service.result
  end

  private

  def rps_service
    @rps_service ||= ::RpsService::Main.new(user_bet: user_bet)
  end

  def user_bet
    params[:id]
  end
end