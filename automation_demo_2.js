#import "env.js"
#import "tuneup_js/tuneup.js"

test("Map Screen", function(target, app) {
  mainWindow = app.mainWindow();
  navBar = mainWindow.navigationBar();
  leftButton = navBar.leftButton();
  rightButton = navBar.rightButton();

  assertEquals("Locate Me", leftButton.name());
  assertEquals("List Stops", rightButton.name());
});

test("Test name", function(target, app) {
  mainWindow = app.mainWindow();
  navBar = mainWindow.navigationBar();
  leftButton = navBar.leftButton();
  rightButton = navBar.rightButton();

  assertEquals("Locate Me", leftButton.name());
  rightButton.tap();
  // test that list gets exposed and is populated.

  target.delay(3);
});