// #import "env.js"

#import "snapper_helpers.js"

var target = UIATarget.localTarget();
var app = target.frontMostApp();
var window = app.mainWindow();

var dumpJSON = function(elt) {
  if (elt.isNil()) {
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

  if (elt.elements().isNil()) {
    output = null;
  } else {
    elt.elements().collect(function(index, e) {
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