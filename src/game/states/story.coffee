class Story

	create: ->
		@input.onDown.add @onDown, this


	update: ->



	onDown: ->

		@game.state.start 'game'

module.exports = Story