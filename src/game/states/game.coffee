class Game

  @player = null 
  @successTxt = null

  create: ->
    #setup game window
    x = @game.width / 3
    y = @game.height / 2   
    @starx = @game.width / 2
    @stary = @game.height / 2

    #add Sprites
    @game.add.sprite 0, 0, 'Plough'
    @star = @add.sprite @starx, @stary, 'star'
    @player = @add.sprite x, y, 'player'

    #setup game input/output
    @input.onDown.add @onInputDown, this
    @cursors = @game.input.keyboard.createCursorKeys()

    #setup game physics
    @game.physics.startSystem Phaser.Physics.P2JS
    @game.physics.p2.enable @player
    @game.physics.p2.defaultRestitution = 0.8
    @player.body.fixedRotation = true
    @player.body.setZeroDamping()

    @successTxt = @add.text(200, 200, "Plink", { font: "65px Arial", fill: "#ff0044", align: "center" })
    @printed = false

  update: ->
     @player.body.setZeroVelocity()

     @xdistance = Math.abs(@player.x - @star.x)
     @ydistance = Math.abs(@player.y - @star.y)

     if @xdistance < 10 && @ydistance < 10 
        if not @printed
     	   @successTxt = @add.text(200, 200, "Yay!", { font: "65px Arial", fill: "#ff0044", align: "center" })
     	   @printed = true
     else 
     	@successTxt.destroy()
     	@printed = false

     if @cursors.left.isDown
     	@player.body.moveLeft(200)
     else if @cursors.right.isDown
     	@player.body.moveRight(200)
     if @cursors.up.isDown
     	@player.body.moveUp(200)
     else if @cursors.down.isDown
     	@player.body.moveDown(200)

  onInputDown: ->
    @game.state.start 'menu'


module.exports = Game
