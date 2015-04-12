controllers = require './controllers'

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
    startingStar: 0,
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

PLAYERS = [
  {sprite: 'player'},
  {sprite: 'player2'},
  {sprite: 'player3'}
]

class Game

  @successTxt = null

  create: ->
    @levelnum = 0
    @drawLevel(@levelnum)
    @input.onDown.add @onDown, this

  onDown: ->
    if @levelcomplete
       @levelnum++
       @drawLevel(@levelnum)

  drawLevel: (@levelnum) ->
    #setup game window
    @level = LEVELS[@levelnum]
    x = @level.starsArray[@level.startingStar].x
    y = @level.starsArray[@level.startingStar].y

    #add Sprites
    @game.add.sprite 0, 0, 'background'
    #Plot empty stars
    @constellation = []
    @levelcomplete = false
    @drawConstellation(@level)

    @game.physics.startSystem Phaser.Physics.Arcade

    @players = []
    for player in PLAYERS
      @players.push @drawPlayer(player, x, y)

    #add sounds
    #@soundSputnik = @game.add.audio 'soundSputnik'

    #setup game input/output
    @cursors = @game.input.keyboard.createCursorKeys()
    controllers(@game, @players)

    @printed = false


  update: ->
    #@player.body.setZeroVelocity()

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
                @game.add.tween(star).to({alpha:1},200,Phaser.Easing.Quintic.Out,true)
                star.active = true
        else
            # no players on star
            if star.active
                @game.tweens.removeFrom(star)
                @game.add.tween(star).to({alpha:0.1},15000,Phaser.Easing.Quintic.Out,true)
                star.active = false

        if won
            if star.alpha < 0.35
                won = false

    if won
        @add.text(230, 4, "Congratulations! Level Complete!", { font: "15px Arial", fill: "#ff0044", align: "center" })
        @levelcomplete = true

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

  drawPlayer: (player, x, y) ->
    playerObj = @add.sprite x, y, player.sprite
    playerObj.anchor.setTo 0.5, 0.5
    playerObj.scale.set 0.5,0.5
    @game.physics.enable(playerObj, Phaser.Physics.ARCADE)
    return playerObj


module.exports = Game
