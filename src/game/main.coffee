window.onload = ->
  'use strict'

  Phaser = require 'phaser'

  game = new Phaser.Game 700, 700, Phaser.AUTO, 'constellations'
  game.currentLevel = 0

  # Game States
  game.state.add 'boot', require './states/boot'
  game.state.add 'preloader', require './states/preloader'
  game.state.add 'menu', require './states/menu'
  game.state.add 'game', require './states/game'
  game.state.add 'story', require './states/story'
  game.state.add 'script', require './states/script'
  game.state.add 'postcard', require './states/postcard'

  game.state.start 'boot'
