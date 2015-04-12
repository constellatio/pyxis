LEVELS = [
  {
    spritename: 'ursaminorpc',
  },
  {
    spritename: 'npc',
  },
  {
    spritename: 'npc',
  },
  {
    spritename: 'npc',
  },
  {
    spritename: 'npc',
  },
  {
    spritename: 'npc',
  },
  {
    spritename: 'npc',
  },
  {
    spritename: 'npc',
  },
  {
    spritename: 'npc',
  },
]

class Postcard

  create: ->
    @levelnum = @game.currentLevel
    @level = LEVELS[@levelnum]
    @postcard = @game.add.sprite 0, 0, @level.spritename
    @postcard.anchor.setTo 0, 0
    @postcard.scale.setTo 0.5, 0.5
    @input.onDown.add @onDown, this

  onDown: ->
      @game.currentLevel++
      @game.state.start 'script'

module.exports = Postcard