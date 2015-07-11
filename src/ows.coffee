###!
 * @license ows
 * (c) sugarshin
 * License: MIT
###

"use strict"

isArray = require 'isarray'

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
    @_remove @_set, payload
    @_emitChange()
    return true

  has: (payload) -> @_includes @_set, payload

  clear: ->
    if @_set.length > 0
      @_set.length = 0
      @_emitChange()
    return this

  _includes: (array, payload) ->
    if array.indexOf(payload) > -1
      return true
    else
      return false

  _remove: (array, payload) ->
    for el, i in array
      if el is payload
        array.splice i, 1
    return array

  _emitChange: -> @emit CHANGE_EVENT, @_set

  # alias
  addChangeListener: @::on
  removeChangeListener: @::off
