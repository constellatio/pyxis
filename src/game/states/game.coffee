LEVELS = [
  {
    name: 'The Plough',
    numStars: 7,
    starsArray: [
        {x: 200, y: 200},
        {x: 200, y: 200},
        {x: 200, y: 200},
        {x: 200, y: 200},
        {x: 200, y: 200},
        {x: 200, y: 200},
        {x: 200, y: 200},
    ]
  },
  {
    name: 'The Plough',
    numStars: 7,
    starsArray: [
        {x: 200, y: 200},
        {x: 200, y: 200},
        {x: 200, y: 200},
        {x: 200, y: 200},
        {x: 200, y: 200},
        {x: 200, y: 200},
        {x: 200, y: 200},
    ]
  },
  {
    name: 'The Plough',
    numStars: 7,
    starsArray: [
        {x: 200, y: 200},
        {x: 200, y: 200},
        {x: 200, y: 200},
        {x: 200, y: 200},
        {x: 200, y: 200},
        {x: 200, y: 200},
        {x: 200, y: 200},
    ]
  },
]


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
    @star = @add.sprite @starx, @stary, 'unlitstar'
    @player = @add.sprite x, y, 'player'

    #add sounds
    @soundSputnik = @game.add.audio 'soundSputnik'

    #setup game input/output
    @input.onDown.add @onInputDown, this
    @cursors = @game.input.keyboard.createCursorKeys()

    #setup game physics
    @game.physics.startSystem Phaser.Physics.P2JS
    @game.physics.p2.enable @player
    @game.physics.p2.defaultRestitution = 0.8
    @player.body.fixedRotation = true
    @player.body.setZeroDamping()

    @printed = false

  update: ->
     @player.body.setZeroVelocity()

     @xdistance = Math.abs(@player.x - @star.x)
     @ydistance = Math.abs(@player.y - @star.y)

     if @xdistance < 10 && @ydistance < 10 
        if not @printed
     	   @star.destroy()
     	   @star = @add.sprite @starx, @stary, 'litstar'
     	   @printed = true
     else 
        if @printed
     	   @star.destroy()
     	   @star = @add.sprite @starx, @stary, 'unlitstar'
     	   @printed = false

     if @cursors.left.isDown
        @player.body.moveLeft(200)
     else if @cursors.right.isDown
        @player.body.moveRight(200)
     if @cursors.up.isDown
        @player.body.moveUp(200)
     else if @cursors.down.isDown
        @player.body.moveDown(200)
        #@soundSputnik.play()           Plays A Sound

  onInputDown: ->
    @game.state.start 'menu'



  drawConstellation: (numStars, starsArray) ->


module.exports = Game
