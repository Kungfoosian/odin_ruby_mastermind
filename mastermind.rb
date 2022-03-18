# frozen_string_literal: true

require './classes/board'
require './classes/game'
require './classes/player'

# code_breaker = CodeBreaker.new
# code_maker = CodeMaker.new
# board = Board.new

game = Game.new(CodeMaker.new, CodeBreaker.new, Board.new)
game.play
