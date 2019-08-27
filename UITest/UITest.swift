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
      Swift.print("test start")
      // Some tests
      _ = {
         //      app.firstDescendant(type: .button).waitToAppear(5)?.tap(waitAfter: 2)
         //      app.firstDescendant(id: "someBtn").waitToAppear(5)?.tap(waitAfter: 2)
         //      app.firstDescendant(type: .button, id: "someBtn").waitToAppear(5)?.tap(waitAfter: 2)
         //      app.firstChild(type: .button, id: "otherBtn").waitToAppear(4)?.tap(waitAfter: 2)
         //      _ = app.descendants([(.table, nil), (.button, nil)])
      }()
      let res1 = ElementParser.element(root: app, index: [3,0,0,0])
      Swift.print("res1:  \(res1)")
      let res2 = ElementParser.element(root: app, index: [0,0,2,1])
      Swift.print("res2:  \(res2)")
      let res3 = ElementParser.element(root: app, index: [1,0,2,0])
      Swift.print("res3:  \(res3)")
      let res4 = ElementParser.element(root: app, index: [])
      Swift.print("res4:  \(res4)")
      Swift.print("test end")
   }
//   override func tearDown() {}
   func testExample() {
//            let optionalSelf:XCUIElement? = Optional(self)
//            optionalSelf.waitToAppear(10)?.tap()
   }
}
