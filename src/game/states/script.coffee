LEVELS = [
  {
     dialogArray: [
        {speech: "Who put out all the stars? I need to get back to base\n with all this loot.", speaker: 0},
        {speech: "Woof (I'm getting hungy)", speaker:1},
        {speech: "Can we use any of the other stars to find the way?\n I'm sure I've heard you can find lots of stars\n once you've found the Big Dipper.", speaker:2},
        {speech: "There one star still alight. I recognise that one. It's Polaris, the North star. We can use that to find the other stars nearby.", speaker:0}
    ]
  }, 
  {
    dialogArray: [
      {speech: "That's the Little Dipper completed. Where do we go next?", speaker: 0},
      {speech: "Woof (What is a dipper anyway?)", speaker: 1},
      {speech: "I'm sure there are some stars that point to the North Star. Let's try and find them.", speaker: 2},
      {speech: "Full speed ahead!", speaker: 0}
    ]
  },
  {
     dialogArray: [
        {speech: "Merak and Dubhe. What cool names for stars.", speaker: 0},
        {speech: "Woof (How do you even say Dubhe)", speaker:1},
        {speech: "Can we use any of the other stars to find the way?\n I'm sure I've heard you can find lots of stars\n once you've found the Big Dipper.", speaker:2},
        {speech: "Lets follow Mizar and Alkaid. \nThat takes us to a really bright star that's nearby.", speaker:0}
    ]
  }, 
  {
     dialogArray: [
        {speech: "Arcturus in Boötes, the Herdsman. It looks more like an ice cream cone to me.", speaker: 0},
        {speech: "Woof (Pictures made from stars are called asterisms))", speaker:1},
        {speech: "It looks like a huge spike to me.", speaker:2},
        {speech: "The Spike to Spica. Let's go and sort out Virgo next.", speaker:0}
    ]
  },  
  {
     dialogArray: [
        {speech: "I don't have any more leads from here. Lets go back to the Big Dipper.", speaker: 0},
        {speech: "Woof (also known as the Plough or the Great Bear)", speaker:1},
        {speech: "Aye-aye Captain.", speaker:2}
    ]
  }, 
  {
     dialogArray: [
        {speech: "This time lets follow Megrez and Phecda.", speaker: 0},
        {speech: "Woof (who came up with these names)", speaker:1},
        {speech: "Where does that take us?", speaker:2}
        {speech: "Another zodiac constellation. Let's go and relight Leo", speaker: 0},
    ]
  }, 
  {
     dialogArray: [
        {speech: "Deneb in Cygnus is one of the stars in the Summer Triangle", speaker: 0},
        {speech: "Woof (why would a Greek god turn himself into a swan?)", speaker:1},
        {speech: "Can we get to the others?", speaker:2}
        {speech: "We can get to Vega if we fly the same route as before but with a gentle curve.", speaker: 0},
        {speech: "Woof (gentle curve? what sort of direction is that?)", speaker:1},
    ]
  }, 
  {
     dialogArray: [
        {speech: "That's 2 stars out of 3. We should be able to find Altair in Aquilla now.", speaker: 0},
        {speech: "Woof... (the summer triangle. That's a beautiful story about star crossed lovers)", speaker:1},
        {speech: "That should be enough stars to get us back to base this time", speaker:2}
        {speech: "Yes, a job well done.", speaker: 0},
        {speech: "Woof (food!)", speaker:1},
    ]
  }, 
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