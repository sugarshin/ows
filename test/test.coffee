assert = require 'power-assert'

OWS = require '../'

describe 'OWS', ->

  describe 'constructor', ->
    it 'extended EventEmitter', ->
      assert OWS.__super__.constructor.name is 'EventEmitter'
    it 'defined this.store args', ->
      ows = new OWS [1]
      assert ows._set and ows._set[0] is 1
    it 'defined this.store not args', ->
      ows = new OWS
      assert ows._set and Array.isArray(ows._set)

  describe '.add()', ->
    it 'add set', ->
      ows = new OWS
      p = 'payload'
      ows.add p
      assert ows._set.length is 1 and ows._set[0] is p

  describe '.delete()', ->
    it 'delete set', ->
      ows = new OWS
      p = 'payload'
      r = ows.add(p).delete(p)
      assert ows._set.length is 0 and r

  describe '.has()', ->
    it 'has set', ->
      ows = new OWS
      ows.add(1).add(2)
      assert ows.has(1) and ows.has(2)

  describe '.clear()', ->
    it 'clear set', ->
      ows = new OWS
      p = 'payload'
      ows.add(1).add(2).clear()
      assert ows._set.length is 0

  describe 'event listener', ->
    ows = new OWS
    t = false
    cb = -> t = !t
    it '.addChangeListener', ->
      p = 1
      ows.addChangeListener cb
      ows.add(p)
      assert t

    it '.removeChangeListener', ->
      ows.removeChangeListener cb
      ows.add(2)
      assert t
