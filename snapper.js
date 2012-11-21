// #import "env.js"

function extend(destination, source) {
  for (var property in source) {
    destination[property] = source[property];
  }
  return destination;
};

var arrayMethods = {
  each: function(f) {
    for (i = 0; i < this.length; i++) {
      f(i, this[i]);
    }
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

var target = UIATarget.localTarget();
var app = target.frontMostApp();
var window = app.mainWindow();

// UIAElementArray.prototype.notNil = UIAElement.prototype.notNil = function() {
//   this.toString() !== "[object UIAElementNil]";
// };

var dumpJSON = function (elt) {
  var eltData = {
    label: elt.label(),
    name: elt.name(),
    value: elt.value(),
    rect: elt.rect(),
    childLength: elt.elements().length
  };

  elt.elements().each(function(e) {
    UIALogger.logMessage(e.toString());
  });

  // for (var i=0; i < elt.elements().length; i++) {
  //   var kid = elt.elements()[i];
  //
  //   if (kid !== null && typeof kid !== 'undefined' && kid.toString() !== "[object UIAElementNil]") {
  //     UIALogger.logMessage(kid.toString());
  //     kid.logElement();
  //   } else {
  //     UIALogger.logMessage("Skipping child");
  //     // UIALogger.logMessage("Skipping child(" + i + ")");
  //   }
  // }

  return eltData;

  // var kids = elt.elements();
  //
  // UIALogger.logMessage(kids);
  //   children: elt.elements().toArray().map(function(subElt) {
  //     UIALogger.logMessage("" + depth + "");
  //     return dumpJSON(subElt, depth + 1);
  //   })
  // };
};

// window.logElement();

out = JSON.stringify(dumpJSON(window));
UIALogger.logMessage(out);

// var clog = function(x) {
//   UIALogger.logMessage(x);
// };
//
// var logTree = function(elt) {
//   // var eltData = new Object();
//   //
//   // eltData.rect = elt.rect();
//   // eltData.label = elt.label();
//   // eltData.name = elt.name();
//   // eltData.value = elt.value();
//   //
//   // eltData.children = [];
//
//   var kids = elt.elements();
//
//   clog(kids);
//
//   if (kids !== null && kids.notNil()) {
//     for (var i=0; i < kids.length(); i++) {
//       if (kids[i] !== null && kids[i].notNil()) {
//         kids[i].logElement();
//       }
//     }
//   }
// };
// logTree(window);