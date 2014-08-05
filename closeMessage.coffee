kue = require 'kue'
queue = kue.createQueue()

process.once "SIGTERM", (sig) ->
  errhandler = (err) ->
    console.log "Kue is shut down.", err if err?
    process.exit 0
  queue.shutdown errhandler, 5000
