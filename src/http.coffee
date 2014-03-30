'use strict'

http = require 'http'

debug = require('debug')
express = require 'express'
Q = require 'q'
_ = require 'underscore'

{PORT} = require "#{__dirname}/../config"

print = debug 'server'

# app.all '*', (req, res, next) ->
#   res.header "Access-Control-Allow-Origin", "*"
#   res.header "Access-Control-Allow-Methods", "OPTION, GET, OPST, PUT, DELETE"
#   res.header "Access-Control-Allow-Headers", "X-Requested-With"
#   res.header "Access-Control-Allow-Headers", "Content-Type"
#   next()

app = do express

# middleware chain
app.use express.logger()
app.use express.bodyParser()
app.use express.methodOverride()

# routing
app.get '/sensors', (req, res) ->
  res.json 'hello world'

#start server

exports.start = () ->
  port = process.env.PORT  or PORT or 8000
  app.listen port
  print "Listening on port #{port}"
