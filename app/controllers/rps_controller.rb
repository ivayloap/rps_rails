class RpsController < ApplicationController
  def start
  end

  def throw
    @your_bet = params[:id]
    @server_bet ||= rpc_service.generated_bet.to_s
    @result ||= rpc_service.result
  end

  private

  def rpc_service
    @rpc_service ||= ::RpsService::Main.new(user_bet: user_bet)
  end

  def user_bet
    params[:id]
  end
end