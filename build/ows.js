(function(f){if(typeof exports==="object"&&typeof module!=="undefined"){module.exports=f()}else if(typeof define==="function"&&define.amd){define([],f)}else{var g;if(typeof window!=="undefined"){g=window}else if(typeof global!=="undefined"){g=global}else if(typeof self!=="undefined"){g=self}else{g=this}g.OWS = f()}})(function(){var define,module,exports;return (function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(_dereq_,module,exports){

/**
 * Array#filter.
 *
 * @param {Array} arr
 * @param {Function} fn
 * @param {Object=} self
 * @return {Array}
 * @throw TypeError
 */

module.exports = function (arr, fn, self) {
  if (arr.filter) return arr.filter(fn, self);
  if (void 0 === arr || null === arr) throw new TypeError;
  if ('function' != typeof fn) throw new TypeError;
  var ret = [];
  for (var i = 0; i < arr.length; i++) {
    if (!hasOwn.call(arr, i)) continue;
    var val = arr[i];
    if (fn.call(self, val, i, arr)) ret.push(val);
  }
  return ret;
};

var hasOwn = Object.prototype.hasOwnProperty;

},{}],2:[function(_dereq_,module,exports){

var indexOf = [].indexOf;

module.exports = function(arr, obj){
  if (indexOf) return arr.indexOf(obj);
  for (var i = 0; i < arr.length; ++i) {
    if (arr[i] === obj) return i;
  }
  return -1;
};
},{}],3:[function(_dereq_,module,exports){
module.exports = Array.isArray || function (arr) {
  return Object.prototype.toString.call(arr) == '[object Array]';
};

},{}],4:[function(_dereq_,module,exports){

/*!
 * @license event-emitter
 * (c) sugarshin
 * License: MIT
 */
"use strict";
var EventEmitter,
  slice = [].slice;

module.exports = EventEmitter = (function() {
  function EventEmitter() {
    this._events = {};
  }

  EventEmitter.prototype.on = function(event, handler) {
    var base;
    if (typeof handler !== 'function') {
      throw new Error(handler + " is not a function");
    }
    (base = this._events)[event] || (base[event] = []);
    this._events[event].push(handler);
    return this;
  };

  EventEmitter.prototype.once = function(event, handler) {
    var _self;
    if (typeof handler !== 'function') {
      throw new Error(handler + " is not a function");
    }
    this.on(event, _self = (function(_this) {
      return function() {
        _this.off(event, _self);
        return handler.apply(_this, arguments);
      };
    })(this));
    return this;
  };

  EventEmitter.prototype.off = function(event, handler) {
    var handlers, i, len;
    if (!event) {
      return this;
    }
    if (!(handlers = this._events[event])) {
      return this;
    }
    if (handler) {
      i = 0;
      len = handlers.length;
      while (i < len) {
        if (handler === handlers[i]) {
          handlers.splice(i, 1);
        } else {
          i++;
        }
      }
    } else {
      delete this._events[name];
    }
    return this;
  };

  EventEmitter.prototype.emit = function() {
    var args, callbacks, cb, event, j, len1;
    event = arguments[0], args = 2 <= arguments.length ? slice.call(arguments, 1) : [];
    callbacks = this._events[event];
    if (!callbacks) {
      return this;
    }
    for (j = 0, len1 = callbacks.length; j < len1; j++) {
      cb = callbacks[j];
      cb.apply(this, args);
    }
    return this;
  };

  EventEmitter.prototype.one = EventEmitter.prototype.once;

  return EventEmitter;

})();


},{}],5:[function(_dereq_,module,exports){

/*!
 * @license ows
 * (c) sugarshin
 * License: MIT
 */
"use strict";
var CHANGE_EVENT, EventEmitter, OWS, filter, indexOf, isArray,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

isArray = _dereq_('isarray');

indexOf = _dereq_('indexof');

filter = _dereq_('array-filter');

EventEmitter = _dereq_('./event-emitter');

CHANGE_EVENT = 'change';

module.exports = OWS = (function(superClass) {
  extend(OWS, superClass);

  function OWS(_set) {
    this._set = _set != null ? _set : [];
    if (!isArray(this._set)) {
      throw new Error('Argument should be an Array.');
    }
    OWS.__super__.constructor.call(this);
  }

  OWS.prototype.on = function(callback) {
    return OWS.__super__.on.call(this, CHANGE_EVENT, callback);
  };

  OWS.prototype.off = function(callback) {
    return OWS.__super__.off.call(this, CHANGE_EVENT, callback);
  };

  OWS.prototype.add = function(payload) {
    if (!this.has(payload)) {
      this._set.push(payload);
      this._emitChange();
    }
    return this;
  };

  OWS.prototype["delete"] = function(payload) {
    if (!this.has(payload)) {
      return false;
    }
    this._set = filter(this._set, function(el, i) {
      return el !== payload;
    });
    this._emitChange();
    return true;
  };

  OWS.prototype.has = function(payload) {
    if (indexOf(this._set, payload) > -1) {
      return true;
    } else {
      return false;
    }
  };

  OWS.prototype.clear = function() {
    if (this._set.length > 0) {
      this._set.length = 0;
      this._emitChange();
    }
    return this;
  };

  OWS.prototype._emitChange = function() {
    return this.emit(CHANGE_EVENT, this._set);
  };

  OWS.prototype.addChangeListener = OWS.prototype.on;

  OWS.prototype.removeChangeListener = OWS.prototype.off;

  return OWS;

})(EventEmitter);


},{"./event-emitter":4,"array-filter":1,"indexof":2,"isarray":3}]},{},[5])(5)
});
