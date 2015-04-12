class Preloader

  @asset = null
  @ready = false

  preload: ->
    @asset = @add.sprite(320, 240, 'preloader')
    @asset.anchor.setTo 0.5, 0.5
    @load.onLoadComplete.addOnce @onLoadComplete, this
    @load.setPreloadSprite @asset
    @load.image 'player', 'assets/images/blue pirate.png'
    @load.image 'player2', 'assets/images/jon.png'
    @load.image 'player3', 'assets/images/jonr.png'
    @load.image 'pyxis', 'assets/images/Pyxis.png'
    @load.image 'dog', 'assets/images/Cabin Dog.png'
    @load.image 'cat', 'assets/images/cabin cat in helmet.png'
    @load.image 'robot', 'assets/images/Pirate Robot.png'
    @load.image 'background', 'assets/images/background.png'
    @load.image 'litstar', 'assets/images/lit.png'
    @load.image 'unlitstar', 'assets/images/unlit.png'
    @load.image 'star', 'assets/images/star.png'
    @load.image 'ursaminorpc', 'assets/images/Little Bear 2.png'
    @load.image 'npc', 'assets/images/npc.png'
    @load.image 'starMap', 'assets/images/starMap.png'
    @load.image 'mainMenuImage', 'assets/images/pyxisStartScreen.png'
    @load.image 'arrow', 'assets/images/arrow.png'
    @load.audio 'backgroundSound', 'assets/sounds/Background.ogg'
    @load.bitmapFont 'minecraftia', 'assets/fonts/minecraftia.png', 'assets/fonts/minecraftia.xml'

  create: ->
    @asset.cropEnabled = false

  update: ->
    @game.state.start 'menu' unless not @ready

  onLoadComplete: ->
    @ready = true

module.exports = Preloader
