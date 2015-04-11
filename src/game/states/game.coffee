class Game

  @player = null

  create: ->
    x = @game.width / 3
    y = @game.height / 2
    @player = @add.sprite x, y, 'player'
    @input.onDown.add @onInputDown, this
    @cursors = @game.input.keyboard.createCursorKeys()
    @space = @game.input.keyboard.addKey(Phaser.Keyboard.SPACEBAR)

    @game.physics.startSystem(Phaser.Physics.P2JS)
    @game.physics.p2.enable(@player)
    @player.body.applyDamping(2)
    @player.body.fixedRotation = true

  update: ->
     if @cursors.left.isDown
     	@player.body.moveLeft(400)
     if @cursors.right.isDown
     	@player.body.moveRight(400)
     if @cursors.up.isDown
     	@player.body.moveUp(400)
     if @cursors.down.isDown
     	@player.body.moveDown(400)
     if @space.isDown
     	@player.body.moveDown(0)
     	@player.body.moveUp(0)
     	@player.body.moveLeft(0)
     	@player.body.moveRight(0)
	
  onInputDown: ->
    @game.state.start 'menu'

module.exports = Game
