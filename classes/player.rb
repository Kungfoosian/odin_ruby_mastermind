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
    CODE_COLORS.each_value do |value|
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
  private

  def initialize
    @player_guess = []
  end

  def guess
    4.times do |time|
      begin
        print "Enter letter corresponding to color for position #{time + 1}: "

        choice = sanitize(gets.downcase.strip.chomp)
      rescue StandardError => e
        puts e
      else
        @player_guess.push(choice)
      end
    end
  end
end

# CodeMaker
class CodeMaker < Player
  attr_reader :hint

  private

  HINT_COLORS = {
    'color_position_match': 'black',
    'color_exist_wrong_position': 'white',
    'wrong_color_position': '-'
  }.freeze

  def initialize
    @secret_code = []
    @hint = []
  end

  def make_code
    randomize_by = (rand * 10).round

    CODE_COLORS.each_key { |val| @secret_code.push(val) }

    randomize_by.times do
      @secret_code.shuffle!
    end
  end

  def check_guess_of(other_player)
    other_player.each_with_index do |player_guess, index|
      @hint.clear

      if color_position_match?(player_guess, @secret_code[index])
        @hint.push(HINT_COLORS[:color_position_match])

      elsif color_exist_wrong_position?(player_guess)
        @hint.push(HINT_COLORS[:color_exist_wrong_position])

      else
        @hint.push(HINT_COLORS[:wrong_color_position])
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
