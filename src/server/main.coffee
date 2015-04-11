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
console.log interfaces
for name,details in interfaces
	console.log details
	for address in details
		console.log address
		if address.family == 'IPv4' && !address.internal && detail != 'v'
			addresses.push(address.address)

console.log('http://' + addresses[0] + ':8081/pyxis')

server.listen(8081)
app.get '/', (req, res) ->
	res.render('index', {host:addresses[0]})
app.get '/pyxis', (req, res) ->
	res.render('display', {host:addresses[0]})
app.use('/static', express.static(__dirname + '/static'))

# Configure the socket.io
io.sockets.on 'connection', (socket) ->

	# If this is the display socket, keep a reference to it
	socket.on 'display', (data) ->
		display = socket;

	if display != null
		display.emit('connected', {id:socket.id})

	socket.on 'tilt', (data) ->
		#console.log('Tilt ' + data.x + ' ' + data.y + ' ' + data.z);
		#if (data.r != null)
			#console.log('Rotate ' + data.r.alpha + ' ' + data.r.beta + ' ' + data.r.gamma);
		if (display != null)
			display.emit('tilted', {id:socket.id, x:data.x, y:data.y})

	socket.on 'disconnect', (data) ->
		if display == socket
			display = null
		else if not display == null
			display.emit('disconnected', {id:socket.id})
