import Foundation
#if canImport(XCTest)
import XCTest

public class QueryAsserter {
   /**
    * Waits for the provided label to appear on the screen within the provided timeout.
    * ⚠️️ Beta ⚠️️
    * Waits for the provided query to return a non-empty result within the provided timeout.
    *
    * - Parameters:
    *   - app: The XCUIApplication instance to search for the label.
    *   - testCase: The XCTestCase instance to which the assertion should be added.
    *   - labelString: The string of the label to search for.
    *   - timeOut: The timeout in seconds to wait for the label to appear. Default is 5 seconds.
    *
    * - Returns: A boolean indicating whether the query returned a non-empty result within the provided timeout.
    *
    * - Note: This function adds an assertion to the provided XCTestCase instance to check that the label exists.
    * - Fixme: ⚠️️ write example
    */
   public static func waitFor(app: XCUIApplication, testCase: XCTestCase, labelString: String, timeOut: Double = 5) {
      // Get the XCUIElement instance of the label with the provided string
      let label = app.staticTexts[labelString]
      
      // Create a predicate to check if the label exists
      let exists = NSPredicate(format: "exists == true")
      
      // Create an expectation for the label to exist
      testCase.expectation(for: exists, evaluatedWith: label, handler: nil)
      
      // Wait for the expectation to be fulfilled within the provided timeout
      testCase.waitForExpectations(timeout: timeOut, handler: nil)
      
      // Assert that the label exists
      XCTAssert(label.exists)
   }
   /**
    * ⚠️️ Beta ⚠️️
    * Waits for the provided XCUIElement to appear on the screen within the provided timeout.
    *
    * - Important: This method supports optional elements, whereas the native method `element.waitForExistence(timeOut:)` wouldn't be able to evaluate it because the element is nil.
    *
    * - Note: `wait(for:timeout:)` returns an `XCTestWaiterResult`, an enum representing the result of the test. It can be one of four possible values: `completed`, `timedOut`, `incorrectOrder`, or `invertedFulfillment`. Only the first, `completed`, indicates that the element was successfully found within the allotted timeout.
    *
    * - Remark: A big advantage of this approach is that the test suite reads as a synchronous flow. There is no callback block or completion handler. The helper method simply returns a boolean indicating if the element appeared or not.
    *
    * - Parameters:
    *   - element: The XCUIElement to wait for.
    *   - timeOut: The timeout in seconds to wait for the element to appear. Default is 5 seconds.
    *
    * - Returns: A boolean indicating whether the element appeared within the provided timeout.
    *
    * - Example:
    *   ```
    *   waitForElementToAppear(app.firstDescendant { $0.elementType == .table }, timeOut: 10)
    *   ```
    */
   public static func waitForElementToAppear(element: XCUIElement, timeOut: Double = 5) -> Bool {
    // Create a predicate to check if the element exists
    let existsPredicate = NSPredicate(format: "exists == true")
    
    // Create an expectation for the element to exist
    let expectation = XCTNSPredicateExpectation(predicate: existsPredicate, object: element)
    
    // Wait for the expectation to be fulfilled within the provided timeout
    let result = XCTWaiter().wait(for: [expectation], timeout: timeOut)
    
    // Return a boolean indicating whether the element appeared within the provided timeout
    return result == .completed
}
}
#endif
// public static func waitForElementToAppear(element: XCUIElement, testCase: XCTestCase) -> Bool {
//   let predicate = NSPredicate(format: "exists == true")
//   let expectation = testCase.expectation(for: predicate, evaluatedWith: element, handler: nil)
//   let result = XCTWaiter().wait(for: [expectation], timeout: 5)
//   return result == .completed
// }

