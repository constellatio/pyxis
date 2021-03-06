LEVELS = [
  {
    name: 'The Little Dipper',
    numStars: 7,
    startingStar: 0,
    arrowLocX:106,
    arrowLocY:160,
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
    arrowLocX:285,
    arrowLocY:180,
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
    arrowLocX:420,
    arrowLocY:490,
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
    arrowLocX:645,
    arrowLocY:529,
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
    arrowLocX:560,
    arrowLocY:170,
    starsArray: [
        {x: 525, y: 180},
        {x: 410, y: 392},
        {x: 376, y: 493},
        {x: 345, y: 365},
        {x: 454, y: 163},
        {x: 402, y: 193},
        {x: 358, y: 169},        
        {x: 333, y: 91},
        {x: 368, y: 71},
    ]
  },
]

PLAYERS = [
  {sprite: 'player'},
  {sprite: 'pyxis'},
  {sprite: 'dog'},
  {sprite: 'cat'},
  #{sprite: 'player2'},
  #{sprite: 'player3'}
]

class Game

  @successTxt = null

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

    @game.physics.startSystem Phaser.Physics.Arcade

    @players = []
    for player in PLAYERS
      @players.push @drawPlayer(player, x, y)

     #add sounds
    music = @game.add.audio ('backgroundSound')
    music.play() 

    #setup game input/output
    @cursors = @game.input.keyboard.createCursorKeys()
    console.log 'registering for controllers'
    window.controllers.removeAllListeners()
    window.controllers.on 'move', (player, x, y) =>
      @game.physics.arcade.moveToXY(@players[player], x, y, 0, 100)

    @printed = false


  update: ->
    won = true
    active = []
    for star, i in @constellation
        active[i] = false

    for player in @players
        for star, i in @constellation
            @xdistance = Math.abs(player.x - star.x)
            @ydistance = Math.abs(player.y - star.y)
            if (@xdistance < 20 && @ydistance < 20) || @levelcomplete
                active[i] = true

    for star, i in @constellation
        if active[i]
            # if a player on star
            if not star.active
                @game.tweens.removeFrom(star)
                @game.add.tween(star).to({alpha:@starLitAlpha},@lightSpdConstant,Phaser.Easing.Quintic.Out,true)
                star.active = true
        else
            # no players on star
            if star.active
                @game.tweens.removeFrom(star)
                @game.add.tween(star).to({alpha:@starDimAlpha},@dimSpdConstant,Phaser.Easing.Quintic.Out,true)
                star.active = false

        if won
            if star.alpha < 0.35
                won = false

    if won
        @add.text(230, 4, "Congratulations! Level Complete!", { font: "15px Arial", fill: "#ff0044", align: "center" })
        @levelcomplete = true
        @displayMap()

    if @cursors.left.isDown
        @players[0].body.x -= 4
    else if @cursors.right.isDown
        @players[0].body.x += 4
    if @cursors.up.isDown
        @players[0].body.y -= 4
    else if @cursors.down.isDown
        @players[0].body.y += 4

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
    @level = LEVELS[@levelnum]
    if not @map
      @map = @game.add.sprite 0, 0, 'starMap'
      @map.alpha = 0
      @backImage.alpha = 0
      @game.add.tween(@map).to({alpha:1},1000,Phaser.Easing.Linear.Out,true)
      @hereArrow = @game.add.sprite @level.arrowLocX, @level.arrowLocY, 'arrow'
      @hereArrow.anchor.setTo 0.5, 1

  drawPlayer: (player, x, y) ->
    playerObj = @add.sprite x, y, player.sprite
    playerObj.anchor.setTo 0.5, 0.5
    playerObj.scale.set 0.5,0.5
    @game.physics.enable(playerObj, Phaser.Physics.ARCADE)
    return playerObj

module.exports = Game
