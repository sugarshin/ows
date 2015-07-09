###!
 * @license ows
 * (c) sugarshin
 * License: MIT
###

"use strict"

EventEmitter = require 'eventemitter3'
includes = require 'lodash.includes'
remove = require 'lodash.remove'
isArray = require 'isarray'

module.exports =
class OWS extends EventEmitter

  constructor: (@_set = []) ->
    unless isArray(@_set)
      return throw new Error 'Argument should be an Array.'

    super()

  add: (payload) ->
    unless @has payload
      @_set.push payload
      @_emitChange()
    return this

  delete: (payload) ->
    if @has payload
      remove @_set, (el) -> el is payload
      @_emitChange()
    return this

  has: (payload) -> includes @_set, payload

  clear: ->
    if @_set.length > 0
      @_set.length = 0
      @_emitChange()

  entries: ->

  keys: ->

  values: ->

  _emitChange: -> @emit 'change', @_set
