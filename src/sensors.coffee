'use strict'

r = require 'rethinkdb'
_ = require 'underscore'
Q = require 'q'
debug = require('debug') 'maclabService:sensors'

TABLENAME = 'sensorData'

connect = () ->
  Q.nfcall(r.connect, {host: 'localhost', port: 28015, db: 'sensors'})
  .then (conn) ->
    debug 'rethinkdb connected.'
    conn
  .catch (err) ->
    debug  'rethinkdb connection failed: %j', err

connectClose = (conn) ->
  conn.close (err) ->
    throw err if err
    return

exports.get = (query, cb) ->
    connect()
    .then (conn) ->
       if query.id?
          r.table(TABLENAME).get(query.id).run conn, (err, result) ->
            connectClose(conn) if conn
            return cb err if err
            cb null, result
    .catch (err) ->
      cb err

exports.insert = (type, content, cb) ->
    content.type = type
    insert = r.table(TABLENAME).insert content
    connect()
    .then (conn) ->
      insert.run conn, (err, result) ->
        connectClose(conn) if conn
        return cb(err) if err
        debug 'inserted %j', result
        cb err, result
