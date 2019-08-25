import XCTest
import UITestSugar
/**
 * UITest for UITestSugar
 */
class UITest: XCTestCase {
   override func setUp() {
      super.setUp()
      continueAfterFailure = false
      let app = XCUIApplication()
      app.launch()
      // Some tests
      app.firstDescendant(type: .button).waitToAppear(5)?.tap(wait: 2)
      app.firstDescendant(id: "someBtn").waitToAppear(5)?.tap(wait: 2)
      app.firstDescendant(type: .button, id: "someBtn").waitToAppear(5)?.tap(wait: 2)
      app.firstChild(type: .button, id: "otherBtn").waitToAppear(4)?.tap(wait: 3)
      app.descendants([(.table,nil),(.button)])
   }
//   override func tearDown() {}
//   func testExample() {
      //      let optionalSelf:XCUIElement? = Optional(self)
      //      optionalSelf.waitToAppear(10)?.tap()
//   }
}
