# frozen_string_literal: true

# Player
class Player
  private

  CODE_COLORS = {
    'y': 'yellow',
    'r': 'red',
    'b': 'blue',
    'p': 'purple',
    'g': 'green',
    'o': 'orange'
  }.freeze

  def sanitize(input)
    raise StandardError, "\tERROR: Enter 1 character that correspond to the color you want" unless input.length.eql?(1)

    raise StandardError, "\tERROR: Choice '#{input}' not allowed" unless CODE_COLORS.key?(input.to_sym)

    input
  end

  def print_options
    print "\n"
    CODE_COLORS.each_value do |value| # Add [] around first letter of each color for user to choose
      value = value.split(//)
      value[0] = "[#{value[0]}]"
      value = value.join
      print "#{value}    "
    end
    print "\n"
  end
end

# CodeBreaker
class CodeBreaker < Player
  attr_reader :guesses

  def guess
    print_options
    @guesses.clear
    require 'pry-byebug'; binding.pry
    4.times do |time|
      begin
        print "Enter letter corresponding to color for position #{time + 1}: "

        choice = sanitize(gets.downcase.strip.chomp)
      rescue StandardError => e
        puts e
      else
        @guesses.push(choice)
      end
    end
  end

  private

  def initialize
    @guesses = []
  end
end

# CodeMaker
class CodeMaker < Player
  attr_reader :hint

  def check_guess_of(other_player)
    @hint.clear

    other_player.guesses.each_with_index do |player_guess, index|
      if color_position_match?(player_guess, @secret_code[index])
        @hint.push(HINT_MARKERS[:color_position_match])

      elsif color_exist_wrong_position?(player_guess)
        @hint.push(HINT_MARKERS[:color_exist_wrong_position])

      else
        @hint.push(HINT_MARKERS[:wrong_color_position])
      end
    end

    @hint
  end

  private

  HINT_MARKERS = {
    'color_position_match': 'o',
    'color_exist_wrong_position': 'x',
    'wrong_color_position': '-'
  }.freeze

  def initialize
    @secret_code = make_code
    @hint = []
  end

  def make_code
    result = []

    shuffle_by = (rand * 10).round

    CODE_COLORS.each_key { |value| result.push(value.to_s) }

    shuffle_by.times { result.shuffle! }

    result = result.sample(4) # Remove return when finish debug

    puts "\t\tDEBUG!!!! Secret code is #{result}" # DEBUG

    result
  end

  def color_position_match?(player_guess, my_code)
    player_guess.eql?(my_code)
  end

  def color_exist_wrong_position?(player_guess)
    @secret_code.include?(player_guess)
  end
end
