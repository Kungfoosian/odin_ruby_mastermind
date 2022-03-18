# frozen_string_literal: true

require './classes/board'
require './classes/game'
require './classes/player'


game = Game.new(CodeMaker.new, CodeBreaker.new, Board.new)
game.play
