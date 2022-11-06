#if os(iOS)
import Foundation
import XCTest

public class QueryAsserter {
   /**
    * ⚠️️ Beta ⚠️️
    * Fixme write example
    * - Parameters:
    *   - app: The app to target
    *   - testCase: ?
    *   - labelString: ?
    *   - timeOut: time to wait before failing
    */
   public static func waitFor(app: XCUIApplication, testCase: XCTestCase, labelString: String, timeOut: Double = 5) {
      let label = app.staticTexts[labelString]
      let exists = NSPredicate(format: "exists == true")
      testCase.expectation(for: exists, evaluatedWith: label, handler: nil)
      testCase.waitForExpectations(timeout: timeOut, handler: nil)
      XCTAssert(label.exists)
   }
   /**
    * ⚠️️ Beta ⚠️️
    * - Note: wait(for:timeout:) returns an XCTestWaiterResult, an enum representing the result of the test. It can be one of four possible values: completed, timedOut, incorrectOrder, or invertedFulfillment. Only the first, completed, indicates that the element was successfully found within the allotted timeout.
    * - Remark: A big advantage of this approach is that the test suite reads as a synchronous flow. There is no callback block or completion handler. The helper method simply returns a boolean indicating if the element appeared or not.
    * - Parameters:
    *   - element: The element to wait for to appear
    *   - timeOut: time to wait before failing
    * - Important: ⚠️️ as oppose to the native method element.waitForExistence(timeOut:) This method supports optional elements. where as the native method wouldnt even be able to evaluate it because the element is nil
    * ## Examples:
    * waitForElementToAppear(app.firstDescendant { $0.elementType == .table }, timeOut: 10)
    */
   public static func waitForElementToAppear(element: XCUIElement, timeOut: Double = 5) -> Bool {
      let existsPredicate = NSPredicate(format: "exists == true")
      let expectation = XCTNSPredicateExpectation(predicate: existsPredicate, object: element)
      let result = XCTWaiter().wait(for: [expectation], timeout: timeOut)
      return result == .completed
   }
}
//public static func waitForElementToAppear(element: XCUIElement, testCase: XCTestCase) -> Bool {
//   let predicate = NSPredicate(format: "exists == true")
//   let expectation = testCase.expectation(for: predicate, evaluatedWith: element, handler: nil)
//   let result = XCTWaiter().wait(for: [expectation], timeout: 5)
//   return result == .completed
//}

#endif