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

var collectChildren = function(elt) {
  return elt.elements().collect(function(index, e) {
    if (e.isNil()) {
      return null;
    } else {
      var t = Object.prototype.toString.call(e);
      log(t + " (" + e.elements().length + ")");

      if (e.elements().length > 0) {
        return dumpJSONTree(e);
      } else {
        return dumpJSON(e);
      }
    }
  });
};

var dumpChildren = function(elt) {
  var children;

  if (elt.isNil() || elt.elements().isNil()) {
    children = null;
  } else {
    try {
      children = collectChildren(elt);
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

methods = [
    "activityIndicators", "activityView", "buttons", "collectionViews", "images",
    "links", "navigationBars", "pageIndicators", "pickers", "popover",
    "progressIndicators", "scrollViews", "searchBars", "secureTextFields",
    "segmentedControls", "sliders", "staticTexts", "switches", "tabBars",
    "tableViews", "textFields", "textViews", "toolbars", "webViews"
  ]

methods.each(function(i, name) {
  if (typeof window[name] !== 'undefined') {
    log(name + " (" + window[name]().length + ")");
  } else {
    log("Set your minimum iOS deployment target to 6.0 to use " + name);
  }
});

log("AI: " + window['activityIndicators']().length);

// log(JSON.stringify(dumpJSONTree(window)));
// target.captureScreenWithName(app.bundleID());