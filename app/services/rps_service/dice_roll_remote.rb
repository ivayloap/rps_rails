require 'net/http'

module RpsService
  class DiceRollRemote
    # The dice returns either 1, 2 or 3 in the :result
    THREE_WAY_DICE_URL = 'https://rolz.org/api/?1d3.json'.freeze

    def call
      return unless available?

      dice_roll = to_json['result']
      [:rock, :paper, :scissors][dice_roll - 1]
    end

    def available?
      response.is_a?(Net::HTTPSuccess)
    end

    private

    def to_json
      JSON.parse(response.body)
    end

    def response
      Rails.logger.info("Calling #{uri}") unless @response
      @response ||= Net::HTTP.get_response(uri)
    rescue SocketError => e
      Rails.logger.error("There was an error calling #{uri} -> #{e}")
    end

    def uri
      URI(THREE_WAY_DICE_URL)
    end

  end
end
