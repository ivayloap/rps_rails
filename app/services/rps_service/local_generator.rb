module RpsService
  class LocalGenerator
    def call
      Rails.logger.info("Calling local generator")
      [:rock, :paper, :scissors].sample
    end
  end
end