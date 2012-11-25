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

  if (elt.isNil() || elt.elements().isNil()) {
    children = null;
  } else {
    try {
      children = elt.elements().collect(function(index, e) {
        var kid = null;
        try {
          var t = Object.prototype.toString.call(e);
          log(t + " (" + e.elements().length + ")");
          return dumpJSON(e);
        } catch (ex) { }
        return kid;
      });
    } catch (ex) {
      children = null;
    }
  }
  return children;
};

var dumpJSONTree = function(elt) {
  var eltData = dumpJSON(elt);

  if (eltData === null) {
    return null;
  }

  var children = dumpChildren(elt);
  children.unshift(eltData);

  return children;
};

log(JSON.stringify(dumpJSONTree(window)));
target.captureScreenWithName(app.bundleID());