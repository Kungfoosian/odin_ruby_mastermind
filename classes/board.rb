# frozen_string_literal: true

# Board
class Board
  attr_reader :GUESS_SEPARATOR, :HINT_SEPARATOR

  GUESS_SEPARATOR = '----|----|----|----'
  HINT_SEPARATOR = '----O----O----O----'

  private

  def print(things_to_print, separator)
    things_to_print.each { |thing| print "#{thing}\t" }

    puts separator
  end

  # def print_guess(guesses)
  #   separator = '----|----|----|----'

  #   guesses.each { |guess| print "#{guess}\t" }

  #   puts separator
  # end

  # def print_hint(hints)
  #   separator = '----O----O----O----'

  #   hints.each { |hint| print "#{hint}\t" }

  #   puts separator
  # end
end
