LEVELS = [
  {
    name: 'The Little Dipper',
    numStars: 7,
    startingStar: 0,
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
    startingStar: 0,
    starsArray: [
        {x: 320, y: 95},
        {x: 411, y: 98},
        {x: 431, y: 211},
        {x: 358, y: 234},
        {x: 336, y: 311},
        {x: 316, y: 380},
        {x: 358, y: 469},
    ]
  },
  {
    name: 'Boötes',
    numStars: 6,
    startingStar: 0,
    starsArray: [
        {x: 586, y: 299},
        {x: 676, y: 226},
        {x: 132, y: 299},
        {x: 70, y: 132},
        {x: 197, y: 85},
        {x: 333, y: 195},       
    ]
  },
  {
    name: 'Virgo',
    numStars: 9,
    startingStar: 0,
    starsArray: [
        {x: 380, y: 372},
        {x: 289, y: 509},
        {x: 90, y: 508},
        {x: 175, y: 390},
        {x: 237, y: 332},
        {x: 254, y: 203},
        {x: 166, y: 181},        
        {x: 335, y: 289},
        {x: 328, y: 187},
        {x: 335, y: 118},
        {x: 348, y: 32},
    ]
  },
  {
    name: 'Leo',
    numStars: 9,
    startingStar: 0,
    starsArray: [
        {x: 77, y: 262},
        {x: 210, y: 175},
        {x: 207, y: 256},
        {x: 455, y: 307},
        {x: 453, y: 231},
        {x: 404, y: 185},
        {x: 414, y: 125},        
        {x: 497, y: 77},
        {x: 528, y: 112},
    ]
  },
  
]


class Game

  @player = null 

  create: ->
    #Constants
    @levelnum = @game.currentLevel
    @dimSpdConstant = 15000
    @lightSpdConstant = 200
    @starDimAlpha = 0.3
    @starLitAlpha = 1

    @drawLevel(@levelnum)
    @input.onDown.add @onDown, this

  onDown: ->

    if @levelcomplete     
       @map = false 
       @drawLevel(@levelnum)      
       @game.state.start 'postcard'


  drawLevel: (@levelnum) ->
    #setup game window
    @level = LEVELS[@levelnum]
    x = @level.starsArray[@level.startingStar].x
    y = @level.starsArray[@level.startingStar].y

    #add Sprites
    if not @backimage
      @backImage = @game.add.sprite 0, 0, 'background'
    
    #Plot empty stars
    @constellation = []
    @levelcomplete = false
    @drawConstellation(@level)
    @add.text(500, 590, @level.name, { font: "24px Arial", fill: "#FFFF00", align: "center" })
    @player = @add.sprite x, y, 'player'
    @player.scale.set 0.5,0.5

     #add sounds
    music = @game.add.audio ('backgroundSound')

    
    music.play() 

    #setup game input/output
    #@input.onDown.add @onInputDown, this
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

     	 if (@xdistance < 20 && @ydistance < 20) || @levelcomplete
        #if Player on star
             @game.add.tween(star).to({alpha:@starLitAlpha},@lightSpdConstant,Phaser.Easing.Quintic.Out,true)
     	 else 

       #if Player not on star
               @game.add.tween(star).to({alpha:@starDimAlpha},@dimSpdConstant,Phaser.Easing.Quintic.Out,true)
               #@game.Tween.removeAllTweens()
     	 if won
     	    if star.alpha < 0.35
     	       won = false
         
     if won
     	@add.text(230, 4, "Congratulations! Level Complete!", { font: "15px Arial", fill: "#ff0044", align: "center" })
     	@levelcomplete = true
      @displayMap() 

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

  drawConstellation: (level) ->
     console.log @constellation
     for star, i in level.starsArray
        star = @add.sprite star.x, star.y, 'litstar'
        if i == level.startingStar
             star.alpha = 1
        else
             star.alpha = 0.3
        star.anchor.setTo 0.5, 0.5
        star.scale.set 0.5, 0.5
        @constellation.push(star)

  displayMap: ->
    if not @map
      @map = @game.add.sprite 0, 0, 'starMap'
      @map.alpha = 0
      @backImage.alpha = 0
      @game.add.tween(@map).to({alpha:1},1000,Phaser.Easing.Linear.Out,true)


module.exports = Game
