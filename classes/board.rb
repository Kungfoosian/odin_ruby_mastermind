# frozen_string_literal: true

# Board
class Board
  private

  def initialize
    @row = []
  end

  def print_options
    COLORS.each_value do |value|
      value = value.split(//)
      value[0] = "[#{value[0]}]"
      value = value.join
      print "#{value}\t"
    end
    print "\n"
  end
end