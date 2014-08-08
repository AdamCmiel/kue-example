express = require 'express'
kue = require 'kue'

app = express()
queue = kue.createQueue require './config.json'

# Handle process SIGTERM
require './closeMessage'

# Queue worker
require './worker'

# Respond to server request
app.use "/enqueue", require './request'
app.use "/", kue.app

# Listen on device ports
# kue_port = 4030
# kue.app.listen kue_port
# console.log "Kue listening on port #{kue_port}"
app_port = process.env.PORT || 5000 
app.listen app_port
console.log "App listening on port #{app_port}"
