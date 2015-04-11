LEVELS = [
  {
    name: 'The Little Dipper',
    numStars: 8,
    starsArray: [
        {x: 309, y: 40},
        {x: 257, y: 125},
        {x: 220, y: 235},
        {x: 247, y: 357},
        {x: 189, y: 391},
        {x: 261, y: 508},
        {x: 272, y: 511},
        {x: 319, y: 455},
    ]
  },{
    name: 'The Big Dipper',
    numStars: 7,
    starsArray: [
        {x: 39, y: 107},
        {x: 317, y: 41},
        {x: 485, y: 115},
        {x: 697, y: 189},
        {x: 755, y: 367},
        {x: 1083, y: 350},
        {x: 1115, y: 130},
    ]
  },
  {
    name: 'The Plough',
    numStars: 9,
    starsArray: [
        {x: 381, y: 409},
        {x: 215, y: 286},
        {x: 64, y: 182},
        {x: 101, y: 31},
        {x: 222, y: 52},
        {x: 259, y: 210},
        {x: 288, y: 544},
        {x: 481, y: 397},
        {x: 519, y: 440},
    ]
  },
  
]


class Game

  @player = null 

  create: ->
    #setup game window
    x = @game.width / 3
    y = @game.height / 2   

    #add Sprites
    @game.add.sprite 0, 0, 'Plough'
    #@star = @add.sprite @starx, @stary, 'unlitstar'
    @player = @add.sprite x, y, 'player'
    @constellation = []
    @printed = []

    #Plot empty stars
    @drawConstellation(LEVELS[2])

    #add sounds
    #@soundSputnik = @game.add.audio 'soundSputnik'


    #setup game input/output
    @input.onDown.add @onInputDown, this
    @cursors = @game.input.keyboard.createCursorKeys()

    #setup game physics
    @game.physics.startSystem Phaser.Physics.P2JS
    @game.physics.p2.enable @player
    @game.physics.p2.defaultRestitution = 0.8
    @player.body.fixedRotation = true
    @player.body.setZeroDamping()


  update: ->
     @player.body.setZeroVelocity()

     for star, i in @constellation
     	 @xdistance = Math.abs(@player.x - star.x)
     	 @ydistance = Math.abs(@player.y - star.y)

     	 if @xdistance < 10 && @ydistance < 10 
     	    if not @printed[i]
     	       star.destroy()
     	       star = @add.sprite star.x, star.y, 'litstar'
     	       @printed[i] = true
     	 else 
     	    if @printed[i]
     	       star.destroy()
     	       star = @add.sprite star.x, star.y, 'unlitstar'
     	       @printed[i] = false

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



  drawConstellation: (level) ->
     console.log @constellation
     for star in level.starsArray
        @constellation.push(@add.sprite star.x, star.y, 'unlitstar')
        @printed.push(false)

module.exports = Game
