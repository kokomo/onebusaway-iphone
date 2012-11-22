// #import "env.js"

#import "snapper_helpers.js"

var target = UIATarget.localTarget();
var app = target.frontMostApp();
var window = app.mainWindow();

var dumpJSON = function(elt) {
  if (elt.isNil()) {
    return null;
  }

  var eltData = {
    label: elt.label(),
    name: elt.name(),
    value: elt.value(),
    rect: elt.rect(),
    hint: elt.hint(),
    isValid: elt.isValid(),
    isVisible: triStateBooleanValue(elt.isVisible()),
    stringValue: elt.toString()
  };

  return eltData;
};

var dumpChildren = function(elt) {
  var children;

  if (elt.elements().isNil()) {
    children = null;
  } else {
    children = elt.elements().collect(function(index, e) {
      if (elt.isNil()) {
        return null;
      } else {
        return dumpJSON(e);
      }
    });
  }
  return children;
};

var dumpJSONTree = function(elt) {
  var eltData = dumpJSON(elt);

  if (eltData === null) {
    return null;
  }

  eltData.children = dumpChildren(elt);

  return eltData;
};

log(JSON.stringify(dumpJSONTree(window)));
target.captureScreenWithName(app.bundleID());