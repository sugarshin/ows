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
    remove @_set, (el) -> el is payload
    @_emitChange()
    return true

  has: (payload) -> includes @_set, payload

  clear: ->
    if @_set.length > 0
      @_set.length = 0
      @_emitChange()
    return this

  _emitChange: -> @emit CHANGE_EVENT, @_set

  # alias
  addChangeListener: @::on
  removeChangeListener: @::off
