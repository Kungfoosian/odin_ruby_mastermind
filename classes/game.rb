# frozen_string_literal: true

# Game
class Game
  def play
    until @turns.zero? || @win_condition_met
      @code_breaker.guess

      @board.print_guess(@code_breaker.guesses)

      turn_result = @code_maker.check_guess_of(@code_breaker)

      @win_condition_met = check_for_win(turn_result)

      @board.print_hint(turn_result)

      @turns -= 1
    end

    print_endgame_message
  end

  private

  def initialize(code_maker, code_breaker, board)
    @code_maker = code_maker
    @code_breaker = code_breaker
    @board = board
    @turns = 12
    @win_condition_met = false
  end

  def check_for_win(turn_result)
    turn_result.all? { |hint_marker| hint_marker.eql?('o') }
  end

  def print_endgame_message
    puts '***** You WIN! *****' if @win_condition_met
    puts '***** You LOSE! *****' if @turns.zero?
  end
end
