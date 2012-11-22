var log = function(l) {
  UIALogger.logMessage(l.toString());
};

function extend(destination, source) {
  for (var property in source) {
    destination[property] = source[property];
  }
  return destination;
};

// initial implementation derived from:
// http://stackoverflow.com/questions/10316621/is-it-possible-to-extend-uiaelementarray-with-my-own-methods
var arrayMethods = {
  each: function(f) {
    for (i = 0; i < this.length; i++) {
      f(i, this[i]);
    }
  },

  collect: function(f) {
    var result = [];
    for (i = 0; i < this.length; i++) {
      result.push(f(i, this[i]));
    }
    return result;
  },

  findFirst: function(f) {
    for (i = 0; i < this.length; i++) {
      if (f(this[i])) return this[i];
    }
    return null;
  },

  findLast: function(f) {
    for (i = this.length - 1; i >= 0; i--) {
      if (f(this[i])) return this[i];
    }
    return null;
  }
}

extend( UIAElementArray.prototype, arrayMethods );
extend( Array.prototype, arrayMethods );

var isNilMethod = {
  isNil: function() {
    this.toString() === "[object UIAElementNil]";
  }
};
extend( Object.prototype, isNilMethod );
extend( UIAElement.prototype, isNilMethod );
extend( UIAElementArray.prototype, isNilMethod );

// requires a number or null (e.g. 1, 0 or null -> yes, no, or 'unknown')
var triStateBooleanValue = function(val) {
  if (val > 0) {
    return true;
  } else if (val == 0) {
    return false;
  } else {
    return null;
  }
};