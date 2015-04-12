#io = require 'socket.io'

connect = (game, players) ->
    socket = io.connect('http://' + window.host + ':8081')
    socket.emit('display', null)
    CONTROLLERS = 3
    controllers = []
    lookup = {}

    for i in [0..CONTROLLERS]
      controllers[i] = null

    socket.on 'connected', (data) ->
      for i in [0..CONTROLLERS]
        if controllers[i] is null
          controllers[i] = {x:game.width/2, y:game.height/2}
          lookup[data.id] = i
          console.log 'Connected:' + i
          break

    socket.on 'tilted', (data) ->
      index = lookup[data.id]
      console.log 'Tilted:' + index + ' ' + data.x + ' ' + data.y

      controller = controllers[index]  #index]
      # x = y because we're holding sideways!
      controller.x += data.y
      controller.y += data.x

      controller.x = Math.min(controller.x, game.width)
      controller.x = Math.max(controller.x, 0)
      controller.y = Math.min(controller.y, game.height)
      controller.y = Math.max(controller.y, 0)

      #if index == 0
      #player.body.x = controller.x
      #player.body.y = controller.y
      game.physics.arcade.moveToXY(players[index], controller.x, controller.y, 0, 100)

      #      particle = gl.getUniformLocation gl.shaderProgram, 'u_positions[' + (index + 1) + ']'
      #      gl.uniform2f particle, controller.x / gl.width, controller.y / gl.height

    socket.on 'disconnected', (data) ->
      controllers[lookup[data.id]] = null
      delete lookup[data.id]

module.exports = connect