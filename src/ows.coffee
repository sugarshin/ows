###!
 * @license ows
 * (c) sugarshin
 * License: MIT
###

"use strict"

isArray = require 'isarray'
indexOf = require 'indexof'
filter = require 'array-filter'

EventEmitter = require './event-emitter'

CHANGE_EVENT = 'change'

module.exports =
class OWS extends EventEmitter

  constructor: (@_set = []) ->
    unless isArray(@_set)
      return throw new Error 'Argument should be an Array.'

    super()

  on: (callback) -> super CHANGE_EVENT, callback

  off: (callback) -> super CHANGE_EVENT, callback

  add: (payload) ->
    unless @has payload
      @_set.push payload
      @_emitChange()
    return this

  delete: (payload) ->
    return false unless @has payload
    @_set = filter @_set, (el, i) -> el isnt payload
    @_emitChange()
    return true

  has: (payload) ->
    if indexOf(@_set, payload) > -1
      return true
    else
      return false

  clear: ->
    if @_set.length > 0
      @_set.length = 0
      @_emitChange()
    return this

  _emitChange: -> @emit CHANGE_EVENT, @_set

  # alias
  addChangeListener: @::on
  removeChangeListener: @::off
