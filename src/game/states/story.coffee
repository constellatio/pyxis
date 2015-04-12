class Story

    create: ->

        @text = "Pyxis, the dashing space pirate, has lost the constellations and can’t navigate her star ship. \n \n As her space pirate friends, you can help her by lighting up the constellations. Once you've lit up a constellation, you will get a clue where to find the next one. \n To help you, Pyxis has some vials of stardust. Stardust makes stars stay bright for longer. But it can't turn them back on permanently."
        @style = { font: "40px sans-serif", fill: "#FFFFFF", align: "center", wordWrap: true, wordWrapWidth: 650}
        @t = @game.add.text(@game.world.centerX-300, @game.world.centerY+300, @text, @style)

        @input.onDown.add @onDown, this
    update: ->

        @t.y = @t.y - 0.45

        #@newColour = @t.font;
        #@newColour.fill = '#8B0000';
        #@t.setStyle @newColour;

    onDown: ->

        @game.state.start 'script'

module.exports = Story