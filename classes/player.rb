# frozen_string_literal: true

# Player
class Player
  protected

  attr_reader :player_guess

  private

  CODE_COLORS = {
    'y': 'yellow',
    'r': 'red',
    'b': 'blue',
    'p': 'purple',
    'g': 'green',
    'o': 'orange'
  }.freeze

  HINT_COLORS = {
    'b': 'black',
    'w': 'white'
  }.freeze

  def initialize
    @player_guess = []
  end

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
  private

  def make_code
    randomize_by = (rand * 10).round
    code = nil

    randomize_by.times do

    end
  end
end
