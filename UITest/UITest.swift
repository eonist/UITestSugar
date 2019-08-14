import XCTest
import UITestSugar

class UITest: XCTestCase {
   override func setUp() {
      super.setUp()
      continueAfterFailure = false
      let app = XCUIApplication()
      app.launch()
      // Some tests
      app.firstDescendant(id: "someBtn", type: .button).waitToAppear(5)?.tap(wait: 2)
      app.firstChild(id: "otherBtn", type: .button).waitToAppear(4)?.tap(wait: 3)
   }
//   override func tearDown() {}
//   func testExample() {
      //      let optionalSelf:XCUIElement? = Optional(self)
      //      optionalSelf.waitToAppear(10)?.tap()
//   }
}
