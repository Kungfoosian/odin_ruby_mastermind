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
    # @code_maker.make_code # Call in Player class?

    until @turns.zero? || @win_condition_met
      @code_breaker.guess
      @board.print_guess
      @win_condition_met = @code_maker.guessed_correctly?(@code_breaker)
      @board.print_hint
      @turns -= 1
    end
  end
end
