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
    print "\n\n"
  end
end

# CodeBreaker
class CodeBreaker < Player
  attr_reader :guesses

  def guess
    print_options
    @guesses.clear
    position = 0

    until position.eql?(4)
      print "Color guess for position #{position + 1}: "

      begin
        choice = sanitize(gets.downcase.strip.chomp)
      rescue StandardError => e
        puts e
      else
        @guesses.push(choice)

        position += 1
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

    if duplicate?(@secret_code)
      check_with_duplicate(other_player)
    else
      check_without_duplicate(other_player)
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
    color_choices = []
    result = []

    CODE_COLORS.each_key { |value| color_choices.push(value.to_s) }

    4.times { result.push(color_choices.sample) }

    puts "\t\tDEBUG!!!! Secret code is #{result}" # DEBUG

    result
  end

  def duplicate_count(code)
    code.reduce(Hash.new(0)) do |result, element|
      result[element] += 1

      result
    end
  end

  def duplicate?(code)
    duplicate_result = duplicate_count(code)

    duplicate_result.filter! { |key, value| duplicate_result[key] > 1 }

    duplicate_result.size.positive?
  end

  # FIX!!!!
  def check_with_duplicate(other_player)
    secret_duplicate_result = duplicate_count(@secret_code)
    secret_duplicate_result.filter! { |key, value| duplicate_result[key] > 1 }

    player_duplicate_result = duplicate_count(other_player.guesses)
    player_duplicate_result.filter! { |key, value| player_duplicate_result[key] > 1}
  end

  def check_without_duplicate(other_player)
    other_player.guesses.each_with_index do |player_guess, index|
      if color_position_match?(player_guess, @secret_code[index])
        @hint.push(HINT_MARKERS[:color_position_match])

      elsif color_exist_wrong_position?(player_guess)
        @hint.push(HINT_MARKERS[:color_exist_wrong_position])

      else
        @hint.push(HINT_MARKERS[:wrong_color_position])
      end
    end
  end

  def color_position_match?(player_guess, my_code)
    player_guess.eql?(my_code)
  end

  def color_exist_wrong_position?(player_guess)
    @secret_code.include?(player_guess)
  end
end
