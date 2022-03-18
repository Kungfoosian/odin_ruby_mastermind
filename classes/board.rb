# frozen_string_literal: true

# Board
class Board
  # attr_reader :GUESS_SEPARATOR, :HINT_SEPARATOR

  GUESS_SEPARATOR = '------|------|------|------'
  HINT_SEPARATOR = '------O------O------O------'

  # def print(things_to_print, separator)
  #   things_to_print.each { |thing| print "#{thing}\t" }

  #   puts separator
  # end

  def print_guess(guesses)
    print "\nYour guess:\t"

    guesses.each { |guess| print "#{guess}\t" }

    puts "\n\t\t#{GUESS_SEPARATOR}"
  end

  def print_hint(hints)
    print "\nHint:\t\t"

    hints.each { |hint| print "#{hint}\t" }

    puts "\n\t\t#{HINT_SEPARATOR}"
  end
end
