express = require('express')
app = express()
swig = require('swig')
server = require('http').createServer(app)
io = require('socket.io').listen(server)
os = require('os')
display = null

#io.set('log level', 1)

# Set up our template engine
app.engine('html', swig.renderFile)
app.set('view engine', 'html')
app.set('views', __dirname + '/views')
# don't forget to re-enable caching in production!
app.set('view cache', false)
swig.setDefaults({ cache: false })

# Start up the server
interfaces = os.networkInterfaces()
addresses = []
for name, details of interfaces
	for address in details
		if address.family == 'IPv4' and !address.internal && name != 'v'
			addresses.push(address.address)

console.log('http://' + addresses[0] + ':8081/pyxis')

server.listen(8081)
app.get '/', (req, res) ->
	res.render('client', {host:addresses[0]})
app.get '/pyxis', (req, res) ->
	res.render('display', {host:addresses[0]})
app.use '', express.static(__dirname)

# Configure the socket.io
connections = {}
io.sockets.on 'connection', (socket) ->

	# If this is the display socket, keep a reference to it
	socket.on 'display', (data) ->
		display = socket
		delete connections[socket.id]
		console.log('DISPLAY')
		for connection of connections
			console.log(' - ' + connection)
			display.emit('connected', {id:connection})

	console.log('Connected! ' + socket.id)

	connections[socket.id] = true
	if display != null
		display.emit('connected', {id:socket.id})

	socket.on 'tilt', (data) ->
		#console.log('Tilt ' + socket.id + ' ' + data.x + ' ' + data.y + ' ' + data.z);
		#if (data.r != null)
			#console.log('Rotate ' + data.r.alpha + ' ' + data.r.beta + ' ' + data.r.gamma);
		if (display != null)
			display.emit('tilted', {id:socket.id, x:data.x, y:data.y})

	socket.on 'disconnect', (data) ->
		console.log('Disconnected ' + socket.id)
		if display == socket
			display = null
		else
			delete connections[socket.id]
			if not display == null
				display.emit('disconnected', {id:socket.id})
