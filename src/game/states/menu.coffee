class Menu

  @titleTxt = null
  @startTxt = null
  @mainMenuImage = null

  create: ->
    x = @game.width / 2
    y = @game.height / 2 + 70

    @mainMenuImage = @game.add.sprite 0, 0, 'mainMenuImage'
    @mainMenuImage.scale.set 0.3, 0.3

    @startTxt = @add.bitmapText(x, y, 'minecraftia', 'Engage')
    @startTxt.align = 'center'
    @startTxt.x = @game.width / 2 - @startTxt.textWidth / 2


    @input.onDown.add @onDown, this

  update: ->

  onDown: ->
    @game.state.start 'game'

module.exports = Menu
