import XCTest
import UITestSugar
/**
 * UITest for UITestSugar
 */
class UITest: XCTestCase {
   /**
    * Sets up the test environment.
    * - Remark: This function is called before each test case is run. It sets up the test environment by launching the app and disabling the "continueAfterFailure" flag. This flag determines whether the test should continue running after a failure occurs. If the flag is set to false, the test will stop running after the first failure.
    * - Remark: This function is useful for setting up the test environment in UI testing. You can use it to ensure that the app is launched correctly and that the test environment is set up properly before each test case is run.
    */
   override func setUp() {
      // Set up the test environment by launching the app and disabling the "continueAfterFailure" flag
      super.setUp()
      continueAfterFailure = false
      let app = XCUIApplication()
      app.launch()
      Swift.print("test start")
      // Some tests
      _ = {
         // app.firstDescendant(type: .button).waitToAppear(5)?.tap(waitAfter: 2)
         // app.firstDescendant(id: "someBtn").waitToAppear(5)?.tap(waitAfter: 2)
         // app.firstDescendant(type: .button, id: "someBtn").waitToAppear(5)?.tap(waitAfter: 2)
         // app.firstChild(type: .button, id: "otherBtn").waitToAppear(4)?.tap(waitAfter: 2)
         // _ = app.descendants([(.table, nil), (.button, nil)])
      }()
      _ = {
         // Get the element at index [3, 0, 0, 0] and print the result
         let res1 = ElementParser.element(root: app, index: [3, 0, 0, 0])
         Swift.print("res1:  \(String(describing: res1))")
         // Get the element at index [0, 0, 2, 1] and print the result
         let res2 = ElementParser.element(root: app, index: [0, 0, 2, 1])
         Swift.print("res2:  \(String(describing: res2))")
         // Get the element at index [1, 0, 2, 0] and print the result
         let res3 = ElementParser.element(root: app, index: [1, 0, 2, 0])
         Swift.print("res3:  \(String(describing: res3))")
         // Get the element at index [] and print the result
         let res4 = ElementParser.element(root: app, index: [])
         Swift.print("res4:  \(String(describing: res4))")
      }
      // Wait for the first descendant button to exist and print the result
      let btnExists = app.firstDescendant(type: .button).waitForExistence(timeout: 5)
      Swift.print("btnExists:  \(btnExists ? "✅" : "🚫")")
      // Wait for the first descendant button with a partial ID of "theBtn2" to exist and print the result
      let btn2Exists = app.firstDescendant(partialId: "theBtn2", type: .button).waitForExistence(timeout: 5)
      Swift.print("btn2Exists:  \(btn2Exists)")
      // Print "test end" to indicate the end of the test
      Swift.print("test end")
   }
//   override func tearDown() {}
   func testExample() {
      _ = {}()
//            let optionalSelf:XCUIElement? = Optional(self)
//            optionalSelf.waitToAppear(10)?.tap()
   }
}
