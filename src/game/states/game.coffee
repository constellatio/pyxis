class Game

  @player = null 

  create: ->
    @game.add.sprite 0, 0, 'Plough'
    x = @game.width / 3
    y = @game.height / 2
    starx = @game.width / 2
    stary = @game.height / 2
    @player = @add.sprite x, y, 'player'
    @star = @add.sprite starx, stary, 'star'
    @input.onDown.add @onInputDown, this

    @cursors = @game.input.keyboard.createCursorKeys()
    @space = @game.input.keyboard.addKey(Phaser.Keyboard.SPACEBAR)

    @game.physics.startSystem Phaser.Physics.P2JS
    @game.physics.p2.enable @player
    @game.physics.p2.defaultRestitution = 0.8
    @player.body.fixedRotation = true
    @player.body.setZeroDamping()

  update: ->
     @player.body.setZeroVelocity()

     if @cursors.left.isDown
     	@player.body.moveLeft(200)
     else if @cursors.right.isDown
     	@player.body.moveRight(200)
     if @cursors.up.isDown
     	@player.body.moveUp(200)
     else if @cursors.down.isDown
     	@player.body.moveDown(200)
     if @space.isDown
     	@player.body.moveDown(0)
     	@player.body.moveUp(0)
     	@player.body.moveLeft(0)
     	@player.body.moveRight(0)
	
  onInputDown: ->
    @game.state.start 'menu'


module.exports = Game
