express = require "express"
kue = require "kue"

queue = kue.createQueue()

module.exports = router = express.Router()

router.get "/", (req, res) ->
  job = queue.create "job",
    title: "Foo"
    email: "bar"
  .save (err) ->
    unless err
      console.log "Job successfully queued"
      res.write "Job successfully queued\n"
    else
      console.error "Job queuing failed"
      res.status 500
         .send "Job failed to queue"
    return

  job.on "complete", (result) ->
    console.log "Job completed!", job.id
    console.log result
    res.end "Job complete: #{result}"
  .on "failed", (error) ->
    console.error "There was an error"
    res.end "There was an error building the job"
  .on "progress", (progress) ->
    console.log progress
    res.write "Job progress: #{progress}%\n"
