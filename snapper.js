// #import "env.js"

#import "snapper_helpers.js"

var target = UIATarget.localTarget();
var app = target.frontMostApp();
var window = app.mainWindow();

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

  var output = null;

  if (elt.elements().isNil()) {
    output = null;
  } else {
    output = elt.elements().collect(function(index, e) {
      if (elt.isNil()) {
        return null;
      } else {
        return dumpJSON(e);
      }
    });
  }

  eltData.children = output;

  return eltData;
};

out = JSON.stringify(dumpJSONTree(window));
log(out);