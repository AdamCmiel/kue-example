kue = require 'kue'
queue = kue.createQueue()

queue.process "job", 10, (job, done) ->
  count = 0
  countUp = ->
    if count == 10 then done null, "Job Finished"
    job.progress count++, 10
  counting = setInterval countUp, 500
