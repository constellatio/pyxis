class Game

  @player = null
  @cursors = null

  create: ->
    x = @game.width / 2
    y = @game.height / 2
    @player = @add.sprite x, y, 'player'
    @input.onDown.add @onInputDown, this
    @game.physics.startSystem Phaser.Physics.P2JS
    @game.physics.p2.defaultRestitution = 0.8
    @game.physics.p2.enable @player

    @cursors = @game.input.keyboard.createCursorKeys()

    @player.body.setZeroDamping();

  update: ->

    @player.body.setZeroVelocity()

    if @cursors.left.isDown
        @player.body.moveLeft 400
    else if @cursors.right.isDown
        @player.body.moveRight 400

    if @cursors.up.isDown
        @player.body.moveUp 400
    else if @cursors.down.isDown
        @player.body.moveDown 400
    

  onInputDown: ->
    @game.state.start 'menu'

module.exports = Game
