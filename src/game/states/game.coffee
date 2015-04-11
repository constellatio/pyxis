class Game

  @player = null 

  create: ->
    @game.add.sprite 0, 0, 'Plough'
    x = @game.width / 3
    y = @game.height / 2
    @starx = @game.width / 2
    @stary = @game.height / 2
    @star = @add.sprite @starx, @stary, 'star'
    @player = @add.sprite x, y, 'player'

    @cursors = @game.input.keyboard.createCursorKeys()

    @game.physics.startSystem Phaser.Physics.P2JS
    @game.physics.p2.enable @player
    @game.physics.p2.defaultRestitution = 0.8
    @player.body.fixedRotation = true
    @player.body.setZeroDamping()

  update: ->
     @player.body.setZeroVelocity()

     @xdistance = Math.abs(@player.x - @starx)
     @ydistance = Math.abs(@player.y - @stary)

     if @xdistance < 2 && @ydistance < 2
     	@successTxt = @add.bitmapText(100, 100, 'minecraftia', 'Yay')
     	@successTxt.align = 'center'
     	@successTxt.x = @game.width / 2 - @successTxt.textWidth / 2

     if @cursors.left.isDown
     	@player.body.moveLeft(100)
     else if @cursors.right.isDown
     	@player.body.moveRight(100)
     if @cursors.up.isDown
     	@player.body.moveUp(100)
     else if @cursors.down.isDown
     	@player.body.moveDown(100)
	
  onInputDown: ->
    @game.state.start 'menu'


module.exports = Game
