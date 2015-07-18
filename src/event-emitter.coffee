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
    @_events or= {}
    if typeof handler isnt 'function'
      throw new Error 'on only accepts instances of Function'
    @_events[event] or= []
    @_events[event].push handler
    return this

  one: (event, handler) ->
    @_events or= {}
    if typeof handler isnt 'function'
      throw new Error 'on only accepts instances of Function'
    @on event, _handler = =>
      @off event, _handler
      handler.apply @, arguments
    return this

  off: (event, handler) ->
    unless event
      @_events or= {}
      return this

    return this unless callbacks = @_events[event]

    if handler
      for cb, i in callbacks when cb is handler
        callbacks = callbacks.slice()
        callbacks.splice i, 1
        @_events[event] = callbacks
    else
      delete @_events[name]
    return this

  emit: (event, args...) ->
    callbacks = @_events[event]
    unless callbacks then return this
    for cb in callbacks then cb.apply @, args
    return this

  # Alias
  addListener: @::on
  removeListener: @::off
  rmListener: @::off
  once: @::one
  trigger: @::emit
