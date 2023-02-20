require 'net/http'

module RpsService
  class DiceRollRemote
    # The dice returns either 1, 2, 3 or 4 in the :result
    FOUR_WAY_DICE_URL = 'https://rolz.org/api/?1d4.json'.freeze

    def call
      return unless available?

      dice_roll = to_json['result']
      [:rock, :paper, :scissors, :hammer][dice_roll - 1]
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
      URI(FOUR_WAY_DICE_URL)
    end

  end
end
