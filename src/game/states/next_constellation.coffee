LEVELS = [
  {
    name: 'The Little Dipper',
    arrowLocX:97,
    arrowLocY:168,
    arrownextLocX:197,
    arrownextLocY:168,
  },{
    name: 'The Big Dipper',
    arrowLocX:261,
    arrowLocY:187,
    arrownextLocX:261,
    arrownextLocY:187,
  },
  {
    name: 'Boötes',
    arrowLocX:681,
    arrowLocY:446,
    arrownextLocX:681,
    arrownextLocY:446,
  },
  {
    name: 'Virgo',
    arrowLocX:586,
    arrowLocY:481,
    arrownextLocX:586,
    arrownextLocY:481,
  },
  {
    name: 'Leo',
    arrowLocX:581,
    arrowLocY:156,
    arrownextLocX:581,
    arrownextLocY:156,
  },
]


class StarMap

  create: ->
    #Constants
    @levelnum = @game.currentLevel
    @drawLevel(@levelnum)
    @correct_input = false

    @input.onDown.add @onDown, this
    @cursors = @game.input.keyboard.createCursorKeys()

    #setup game physics
    @game.physics.startSystem Phaser.Physics.P2JS
    @game.physics.p2.enable @arrow
    @game.physics.p2.defaultRestitution = 0.8
    @arrow.body.fixedRotation = true
    @arrow.body.setZeroDamping()

  onDown: ->
    if @correct_input
       @game.state.start 'game'
       @map.destroy()


  drawLevel: (@levelnum) ->
    #setup game window
    @level = LEVELS[@levelnum]
    
    @add.text(500, 590, @level.name, { font: "24px Arial", fill: "#FFFF00", align: "center" })
    @displayMap() 

  update: ->
     @arrow.body.setZeroVelocity()

     @xdistance = Math.abs(@arrow.x - @level.arrownextLocX)
     @ydistance = Math.abs(@arrow.y - @level.arrownextLocY)
     if (@xdistance < 50 && @ydistance < 50) 
        @add.text(10, 10, "Yay",  { font: "24px Arial", fill: "#FFFF00", align: "center" })
        @correct_input = true

     if @cursors.left.isDown
        @arrow.body.moveLeft(200)
     else if @cursors.right.isDown
        @arrow.body.moveRight(200)
     if @cursors.up.isDown
        @arrow.body.moveUp(200)
     else if @cursors.down.isDown
        @arrow.body.moveDown(200) 


  displayMap: ->
    @level = LEVELS[@levelnum]
    @map = @game.add.sprite 0, 0, 'starMap'
    @map.alpha = 0
    @game.add.tween(@map).to({alpha:1},1000,Phaser.Easing.Linear.Out,true)
    @arrow = @game.add.sprite @level.arrowLocX, @level.arrowLocY, 'arrow'

module.exports = StarMap
