module RpsService
  class Main
    attr_accessor :user_bet

    RULE_SET = {
      rock: [:scissors, :hammer],
      paper: [:rock],
      scissors: [:paper],
      hammer: [:scissors, :paper]
    }

    def initialize(user_bet:)
      @user_bet = user_bet.to_sym
    end

    def result
      return :user if RULE_SET[user_bet].include? generated_bet
      return :server if RULE_SET[generated_bet].include? user_bet

      :tie
    end

    # generate locally if remote is not available
    def generated_bet
      @generated_bet ||= if dice_roll_remote.available?
        dice_roll_remote
      else
        local_generator
      end.call
    end

    def local_generator
      @local_generator ||= LocalGenerator.new
    end

    def dice_roll_remote
      @dice_roll_remote ||= DiceRollRemote.new
    end
  end
end