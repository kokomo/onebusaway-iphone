#import "env.js"

var target = UIATarget.localTarget();
var app = target.frontMostApp();
var window = app.mainWindow();
window.logElementTree();

MapScreen.navBar().logElementTree();