window.onload = ->
  'use strict'

  Phaser = require 'phaser'

  Controllers = require './controllers'

  game = new Phaser.Game 700, 700, Phaser.AUTO, 'constellations'
  game.currentLevel = 0
  window.controllers = new Controllers game

  # Game States
  game.state.add 'boot', require './states/boot'
  game.state.add 'preloader', require './states/preloader'
  game.state.add 'menu', require './states/menu'
  game.state.add 'game', require './states/game'
  game.state.add 'story', require './states/story'
  game.state.add 'script', require './states/script'
  game.state.add 'postcard', require './states/postcard'
  game.state.add 'next_constellation', require './states/next_constellation'

  game.state.start 'boot'
