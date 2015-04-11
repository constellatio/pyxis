class Menu

  @titleTxt = null
  @startTxt = null

  create: ->
    x = @game.width / 2
    y = @game.height / 2

    @titleTxt = @add.bitmapText(x, y, 'minecraftia', 'Pyxis')
    @titleTxt.align = 'center'
    @titleTxt.x = @game.width / 2 - @titleTxt.textWidth / 2

    y = y + @titleTxt.height + 5
    @startTxt = @add.bitmapText(x, y, 'minecraftia', 'Engage')
    @startTxt.align = 'center'
    @startTxt.x = @game.width / 2 - @startTxt.textWidth / 2

    @input.onDown.add @onDown, this

  update: ->

  onDown: ->
    @game.state.start 'game'

module.exports = Menu
