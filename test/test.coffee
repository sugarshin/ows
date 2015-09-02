assert = require 'power-assert'

OWS = require '../'

describe 'OWS', ->

  describe 'constructor', ->
    it 'extended EventEmitter', ->
      assert OWS.__super__.constructor.name is 'EventEmitter'
    it 'defined like WeakSet args', ->
      ows = new OWS [1]
      assert ows._set and ows._set[0] is 1
    it 'defined like WeakSet not args', ->
      ows = new OWS
      assert ows._set and Array.isArray(ows._set)

  describe '.add()', ->
    it 'add set success', ->
      ows = new OWS
      p = 'payload'
      ows.add p
      assert ows._set.length is 1 and ows._set[0] is p

    it 'add set fail', ->
      ows = new OWS
      p = 'payload'
      o = k: 1
      a = [1, 2]
      ows.add p
      ows.add p
      ows.add o
      ows.add o
      ows.add a
      ows.add a
      assert(
        ows._set.length is 3 and
        ows._set[0] is p and
        ows._set[1] is o and
        ows._set[2] is a
      )

  describe '.delete()', ->
    it 'delete set success', ->
      ows = new OWS
      p = 'payload'
      p2 = 'payload2'
      o = {}
      a = []
      r1 = ows.add(p).add(p2).delete(p)
      r2 = ows.add(o).delete(o)
      r3 = ows.add(a).delete(a)
      assert ows._set.length is 1 and r1 and r2 and r3

    it 'delete set fail', ->
      ows = new OWS
      p = 'payload'
      r1 = ows.add(p).delete('payload2')
      o = {}
      r2 = ows.add(o).delete({})
      a = []
      r3 = ows.add(a).delete([])
      assert ows._set.length is 3 and !r1 and !r2 and !r3

  describe '.has()', ->
    it 'has set', ->
      ows = new OWS
      ows.add(1).add(2)
      assert ows.has(1) and ows.has(2) and !ows.has('none')

  describe '.clear()', ->
    it 'clear set', ->
      ows = new OWS
      p = 'payload'
      ows.add(1).add(2).clear()
      assert ows._set.length is 0

  describe 'event listener', ->
    it '.addChangeListener', ->
      ows = new OWS
      t = false
      cb = -> t = !t
      p = 1
      ows.addChangeListener cb
      ows.add(p)
      assert t

    it '.on', ->
      ows = new OWS
      t = false
      cb = -> t = !t
      p = 1
      ows.on cb
      ows.add(p)
      assert t

    it '.removeChangeListener', ->
      ows = new OWS
      t = false
      cb = -> t = !t
      ows.removeChangeListener cb
      ows.add(2)
      assert t is false

    it '.removeListener', ->
      ows = new OWS
      t = false
      cb = -> t = !t
      ows.removeListener cb
      ows.add(2)
      assert t is false

    it '.off', ->
      ows = new OWS
      t = false
      cb = -> t = !t
      ows.off cb
      ows.add(2)
      assert t is false
