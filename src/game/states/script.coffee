LEVELS = [
  {
     dialogArray: [
        {speech: "Who put out all the stars? I need to get back to base\n with all this loot.", speaker: 0},
        {speech: "Woof (I'm getting hungy)", speaker:1},
        {speech: "Can we use any of the other stars to find the way?\n I'm sure I've heard you can find lots of stars\n once you've found the Big Dipper.", speaker:2},
        {speech: "Lets follow Mizar and Alkaid. \nThat takes us to a really bright star that's nearby.", speaker:0}
    ]
  }, 
  {
    dialogArray: [
      {speech: "That's the Little Dipper completed. Where do we go next?", speaker: 0},
      {speech: "Woof (What is a dipper anyway?)", speaker: 1},
      {speech: "I'm sure there are some stars that point to the North Star. Let's try and find them.", speaker: 2},
      {speech: "Full speed ahead!", speaker: 0}
    ]
  }
]


class Script
      
  create: ->
    @levelnum = @game.currentLevel
    @level = LEVELS[@levelnum]


    @player = @add.sprite 50, 395, 'player'
    @pxyis = @add.sprite 50, 195, 'pxyis'

    @pxyis_x = 160
    @pxyis_y = 195
    @dog_x = 260
    @dog_y = 295
    @bluey_x = 160
    @bluey_y = 395

    @captainTxt =  @add.text(@pxyis_x, @pxyis_y, "", { font: "18px Arial", fill: "#FFFF00", align: "center" })
    @dogTxt =  @add.text(@dog_x, @dog_y, "", { font: "18px Arial", fill: "#FFFF00", align: "center" })
    @blueyTxt =  @add.text(@bluey_x, @bluey_y, "", { font: "18px Arial", fill: "#FFFF00", align: "center" })
    @index = 0
    @nextDialog()
    @index = 1


    @input.onDown.add @onDown, this

  onDown: ->
    if @index < @level.dialogArray.length
      @nextDialog()
      @index++
    else
      @game.state.start 'game'

  nextDialog:  ->
    console.log(@index)
    @speaker = @level.dialogArray[@index].speaker
    if @speaker == 0
      @captainTxt.destroy()
      @captainTxt =  @add.text(@pxyis_x, @pxyis_y, @level.dialogArray[@index].speech, { font: "18px Arial", fill: "#FFFF00", align: "center" })
    else if @speaker == 1
      @dogTxt.destroy()
      @dogTxt =  @add.text(@dog_x, @dog_y, @level.dialogArray[@index].speech, { font: "18px Arial", fill: "#FFFF00", align: "center" })
    else
      @blueyTxt.destroy()
      @blueyTxt =  @add.text(@bluey_x, @bluey_y, @level.dialogArray[@index].speech, { font: "18px Arial", fill: "#FFFF00", align: "center" })

module.exports = Script