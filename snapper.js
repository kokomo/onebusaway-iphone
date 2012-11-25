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

var dumpedElements = [dumpJSON(window)];

methods = [
    "", "", "", "",
    "", "", "", "",
    "", "", "", "", "",
    "", "", "", "", ""
  ]

var dumpCollection = function(eltArray, dumpChildren) {

  if (typeof dumpChildren === 'undefined') {
    dumpChildren = false;
  }

  if (eltArray.length > 0) {
    return eltArray.collect(function(i, e) {
      if (typeof e !== 'undefined' && !e.isNil()) {
        var ret = dumpJSON(e);

        if (dumpChildren) {
          var kidElts = dumpCollection(e.elements());
          return [ret, kidElts];
        } else {
          return ret;
        }
      }
    });
  } else {
    return [];
  }
};

// TODO: popover(), collectionViews(), tableViews(), scrollViews()

// dumpedElements = dumpedElements.concat(dumpCollection(window.navigationBars(), true));
// dumpedElements = dumpedElements.concat(dumpCollection(window.tabBars(), true));
// dumpedElements = dumpedElements.concat(dumpCollection(window.toolbars(), true));

// dumpedElements = dumpedElements.concat(dumpCollection(window.activityIndicators()));
// dumpedElements = dumpedElements.concat(dumpCollection(window.buttons()));
// dumpedElements = dumpedElements.concat(dumpCollection(window.images()));
// dumpedElements = dumpedElements.concat(dumpCollection(window.links()));
// dumpedElements = dumpedElements.concat(dumpCollection(window.pageIndicators()));
// dumpedElements = dumpedElements.concat(dumpCollection(window.pickers()));
// dumpedElements = dumpedElements.concat(dumpCollection(window.progressIndicators()));
// dumpedElements = dumpedElements.concat(dumpCollection(window.searchBars()));
// dumpedElements = dumpedElements.concat(dumpCollection(window.secureTextFields()));
// dumpedElements = dumpedElements.concat(dumpCollection(window.segmentedControls()));
// dumpedElements = dumpedElements.concat(dumpCollection(window.sliders()));
// dumpedElements = dumpedElements.concat(dumpCollection(window.staticTexts()));
// dumpedElements = dumpedElements.concat(dumpCollection(window.switches()));
// dumpedElements = dumpedElements.concat(dumpCollection(window.textFields()));
// dumpedElements = dumpedElements.concat(dumpCollection(window.textViews()));
// dumpedElements = dumpedElements.concat(dumpCollection(window.webViews()));

// methods.each(function(i, name) {
//   if (typeof window[name] !== 'undefined') {
//     var typedElts = window[name]();
//
//     log(name + " (" + typedElts.length + ")");
//
//     if (typedElts.length > 0) {
//       log("Adding elts!");
//       typedElts.each(function(i, e) {
//         dumpedElements.push(dumpJSON(e))
//       });
//       log(JSON.stringify(dumpedElements));
//     }
//   } else {
//     log("Set your minimum iOS deployment target to 6.0 to use " + name);
//   }
// });


// ppJSON(dumpedElements);

window.logElementTree();

// log(JSON.stringify(dumpedElements));
target.captureScreenWithName(app.bundleID());