express = require 'express'
kue = require 'kue'

app = express()

# Handle process SIGTERM
require './closeMessage'

# Queue worker
require './worker'

# Respond to server request
app.use "/", require './request'

# Listen on device ports
kue_port = 4030
kue.app.listen kue_port
console.log "Kue listening on port #{kue_port}"
app_port = 4040
app.listen app_port
console.log "App listening on port #{app_port}"
