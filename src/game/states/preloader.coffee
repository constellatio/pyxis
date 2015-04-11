class Preloader

  @asset = null
  @ready = false

  preload: ->
    @asset = @add.sprite(320, 240, 'preloader')
    @asset.anchor.setTo 0.5, 0.5
    @load.onLoadComplete.addOnce @onLoadComplete, this
    @load.setPreloadSprite @asset
    @load.image 'player', 'assets/images/blue pirate.png'
    @load.image 'background', 'assets/images/background.png'
    @load.image 'litstar', 'assets/images/lit.png'
    @load.image 'unlitstar', 'assets/images/unlit.png'
    @load.image 'star', 'assets/images/star.png'
    @load.image 'mainMenuImage', 'assets/images/pyxisStartScreen.png'
    @load.audio 'soundSputnik', 'assets/sounds/sputnik.ogg'
    @load.bitmapFont 'minecraftia', 'assets/fonts/minecraftia.png', 'assets/fonts/minecraftia.xml'
    

  create: ->
    @asset.cropEnabled = false

  update: ->
    @game.state.start 'menu' unless not @ready

  onLoadComplete: ->
    @ready = true

module.exports = Preloader
