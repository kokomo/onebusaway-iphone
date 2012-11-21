// #import "env.js"

#import "snapper_helpers.js"

var target = UIATarget.localTarget();
var app = target.frontMostApp();
var window = app.mainWindow();

var dumpJSON = function(elt) {
  if (elt.toString() === "[object UIAElementNil]") {
    return null;
  }

  return {
    label: elt.label(),
    name: elt.name(),
    value: elt.value(),
    rect: elt.rect(),
    stringValue: elt.toString()
  };
};

var dumpJSONTree = function(elt) {

  var eltData = dumpJSON(elt);

  var output = null;

  if (elt.elements().toString() === '[object UIAElementNil]') {
    output = null;
  } else {
    elt.elements().collect(function(index, e) {
      if (elt.toString() === "[object UIAElementNil]") {
        return null;
      } else {
        return dumpJSON(e);
      }
    });
  }

  eltData.children = output;

  return eltData;
};

// window.logElement();

out = JSON.stringify(dumpJSONTree(window));
UIALogger.logMessage(out);