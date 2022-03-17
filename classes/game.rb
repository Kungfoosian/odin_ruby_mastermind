# frozen_string_literal: true

# Game
class Game
  private

  def initialize(code_maker, code_breaker, board)
    @code_maker = code_maker
    @code_breaker = code_breaker
    @board = board
    @turns = 12
    @win_condition_met = false
  end

  def play
    @code_maker.make_code

    until @turns.zero? || @win_condition_met
      @code_breaker.guess

      @board.print_guess(@code_breaker.guesses, GUESS_SEPARATOR)

      turn_result = @code_maker.check_guess_of(@code_breaker)

      @win_condition_met = check_for_win(turn_result)

      @board.print_hint(turn_result, HINT_SEPARATOR)

      @turns -= 1
    end
  end

  def check_for_win(turn_result)
    turn_result.all? { |hint_marker| hint_marker.eql?('v') }
  end
end
