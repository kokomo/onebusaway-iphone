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

var dumpJSONTree = function(elt) {
  var eltData = dumpJSON(elt);

  if (elt.elements().isNil()) {
    eltData.children = null;
  } else {
    eltData.children = elt.elements().collect(function(index, e) {
      if (elt.isNil()) {
        return null;
      } else {
        return dumpJSON(e);
      }
    });
  }

  return eltData;
};

target.captureScreenWithName(app.bundleID());
out = JSON.stringify(dumpJSONTree(window));
log(out);