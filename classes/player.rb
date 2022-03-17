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

    input = input.to_sym

    raise StandardError, "\tERROR: Choice '#{input}' not allowed" unless CODE_COLORS.key?(input)

    CODE_COLORS[input]
  end

  def print_options
    CODE_COLORS.each_value do |value| # Add [] around first letter of each color for user to choose
      value = value.split(//)
      value[0] = "[#{value[0]}]"
      value = value.join
      print "#{value}\t"
    end
    print "\n"
  end
end

# CodeBreaker
class CodeBreaker < Player
  attr_reader :player_guess

  private

  def initialize
    @guesses = []
  end

  def guess
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
end

# CodeMaker
class CodeMaker < Player
  attr_reader :hint

  private

  HINT_MARKERS = {
    'color_position_match': 'o',
    'color_exist_wrong_position': 'x',
    'wrong_color_position': '-'
  }.freeze

  def initialize
    @secret_code = []
    @hint = []
  end

  def make_code
    shuffle_by = (rand * 10).round

    CODE_COLORS.each_key { |value| @secret_code.push(value) }

    shuffle_by.times @secret_code.shuffle!

    @secret_code = @secret_code.sample(4)

    puts "\t\tDEBUG!!!! Secret code is #{@secret_code}" # DEBUG
  end

  def check_guess_of(other_player)
    other_player.guesses.each_with_index do |player_guess, index|
      @hint.clear

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

  def color_position_match?(player_guess, my_code)
    player_guess.eql?(my_code)
  end

  def color_exist_wrong_position?(player_guess)
    @secret_code.include?(player_guess)
  end
end
