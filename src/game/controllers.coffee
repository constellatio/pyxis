#io = require 'socket.io'
{EventEmitter} = require 'events'

CONTROLLERS = 4

class Controllers extends EventEmitter

  constructor: (@game) ->
    console.log 'Setting up socket'
    @socket = io.connect('http://' + window.host + ':8081')
    @controllers = []
    @lookup = {}
    for i in [0..CONTROLLERS]
      @controllers[i] = null

    @socket.on 'connected', (data) =>
      for i in [0..CONTROLLERS]
        if @controllers[i] is null
          @controllers[i] = {x:game.width/2, y:game.height/2}
          @lookup[data.id] = i
          console.log 'Connected: ' + i + ' ' + data.id
          break

    @socket.on 'tilted', (data) =>
      index = @lookup[data.id]
      # console.log 'Tilted:' + index + ' ' + data.x + ' ' + data.y

      controller = @controllers[index]  #index]
      # x = y because we're holding sideways!
      controller.x += data.y
      controller.y += data.x

      controller.x = Math.min(controller.x, @game.width)
      controller.x = Math.max(controller.x, 0)
      controller.y = Math.min(controller.y, @game.height)
      controller.y = Math.max(controller.y, 0)

      @emit 'move', index, controller.x, controller.y

    @socket.on 'disconnected', (data) =>
      console.log 'Disonnected:' + data.id
      @controllers[@lookup[data.id]] = null
      delete @lookup[data.id]

    @socket.emit('display', null)

module.exports = Controllers
