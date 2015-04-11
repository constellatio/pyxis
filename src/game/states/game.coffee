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


class Game

  @player = null 
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
    @player = @add.sprite x, y, 'player'
    @player.anchor.setTo 0.5, 0.5
    @player.scale.set 0.5,0.5

    #add sounds
    #@soundSputnik = @game.add.audio 'soundSputnik'

    #setup game input/output
    #@input.onDown.add @onInputDown, this
    @cursors = @game.input.keyboard.createCursorKeys()

    #setup game physics
    @game.physics.startSystem Phaser.Physics.Arcade
    @game.physics.enable(@player, Phaser.Physics.ARCADE)
    #@game.physics.p2.enable @player
    #@game.physics.p2.defaultRestitution = 0.8
    #@player.body.fixedRotation = true
    #@player.body.setZeroDamping()

    @printed = false

    controllers(@game, @player)
  update: ->
     #@player.body.setZeroVelocity()

     won = true
     for star, i in @constellation
         @xdistance = Math.abs(@player.x - star.x)
         @ydistance = Math.abs(@player.y - star.y)

         if (@xdistance < 20 && @ydistance < 20) || @levelcomplete
            #if Player on star
            if not star.active
                @game.tweens.removeFrom(star)
                @game.add.tween(star).to({alpha:1},200,Phaser.Easing.Quintic.Out,true)
                star.active = true
         else
            #if Player not on star
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
        @player.body.x -= 4
     else if @cursors.right.isDown
        @player.body.x += 4
     if @cursors.up.isDown
        @player.body.y -= 4
     else if @cursors.down.isDown
        @player.body.y += 4
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

module.exports = Game
