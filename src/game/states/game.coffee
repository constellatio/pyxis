LEVELS = [
  {
    name: 'The Little Dipper',
    numStars: 7,
    starsArray: [
        {x: 309, y: 40},
        {x: 257, y: 125},
        {x: 220, y: 235},
        {x: 247, y: 357},
        {x: 189, y: 391},
        {x: 261, y: 508},        
        {x: 319, y: 455},
    ]
  },{
    name: 'The Big Dipper',
    numStars: 7,
    starsArray: [
        {x: 46, y: 275},
        {x: 142, y: 200},
        {x: 221, y: 201},
        {x: 318, y: 193},
        {x: 371, y: 252},
        {x: 497, y: 189},
        {x: 472, y: 97},
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
    #Plot empty stars
    @player = @add.sprite x, y, 'player'
    @constellation = []
    @drawConstellation(LEVELS[0])

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

     won = true
     for star, i in @constellation
     	 @xdistance = Math.abs(@player.x - star.x)
     	 @ydistance = Math.abs(@player.y - star.y)

     	 if @xdistance < 20 && @ydistance < 20 
        #if Player on star
     	       @game.add.tween(star).to({alpha:1},100,Phaser.Easing.Cubic.Out,true)
     	 else 
       #if Player not on star
     	       @game.add.tween(star).to({alpha:0.1},15000,Phaser.Easing.Cubic.Out,true)
     	 if won
     	    if star.alpha < 0.35
     	       won = false
         
     if won
     	@add.text(10, 10, "Congratulations! Level Complete!", { font: "15px Arial", fill: "#ff0044", align: "center" })

     if @cursors.left.isDown
        @player.body.moveLeft(200)
     else if @cursors.right.isDown
        @player.body.moveRight(200)
     if @cursors.up.isDown
        @player.body.moveUp(200)
     else if @cursors.down.isDown
        @player.body.moveDown(200) 
        #Plays A Sound
        #@soundSputnik.play()           


  onInputDown: ->
    @game.state.start 'menu'



  drawConstellation: (level) ->
     console.log @constellation
     for star in level.starsArray
        star = @add.sprite star.x, star.y, 'litstar'
        star.alpha = 0.3
        star.anchor.setTo 0.5, 0.5
        @constellation.push(star)

module.exports = Game
