###!
 * @license event-emitter
 * (c) sugarshin
 * License: MIT
###

"use strict"

module.exports =
class EventEmitter

  constructor: -> @_events = {}

  on: (event, handler) ->
    if typeof handler isnt 'function'
      throw new Error "#{handler} is not a function"
    @_events[event] or= []
    @_events[event].push handler
    return this

  once: (event, handler) ->
    if typeof handler isnt 'function'
      throw new Error "#{handler} is not a function"
    @on event, _self = =>
      @off event, _self
      handler.apply @, arguments
    return this

  off: (event, handler) ->
    unless event then return this
    unless handlers = @_events[event] then return this

    if handler
      i = 0
      len = handlers.length
      while i < len
        if handler is handlers[i]
          handlers.splice i, 1
        else
          i++
    else
      delete @_events[name]
    return this

  emit: (event, args...) ->
    callbacks = @_events[event]
    unless callbacks then return this
    for cb in callbacks then cb.apply @, args
    return this

  # Alias
  one: @::once
