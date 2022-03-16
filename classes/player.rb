# frozen_string_literal: true

# Player
class Player
  private

  def initialize
    @color_options = %w[yellow red blue purple green orange]
    @player_guess = []
  end

  def guess
    4.times do |time|
      print "Enter guess for position #{time+1}: "
    end
  end

  def print_options
    @@color_options.each_with_index do |color_index|
      print ""
    end
  end
end
