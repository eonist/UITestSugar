import Foundation
#if canImport(XCTest)
import XCTest

public class QueryAsserter {
   /**
    * ⚠️️ Beta ⚠️️
    * Waits for the provided label to appear on the screen within the provided timeout.
    * - Description: Waits for the provided query to return a non-empty result within the provided timeout.
    * - Note: This function adds an assertion to the provided XCTestCase instance to check that the label exists.
    * - Parameters:
    *   - app: The XCUIApplication instance to search for the label.
    *   - testCase: The XCTestCase instance to which the assertion should be added.
    *   - labelString: The string of the label to search for.
    *   - timeOut: The timeout in seconds to wait for the label to appear. Default is 5 seconds.
    * - Returns: A boolean indicating whether the query returned a non-empty result within the provided timeout.
    * - Example:
    *   ```
    *   waitFor(app: myApp, testCase: myTestCase, labelString: "Welcome", timeOut: 10)
    *   ```
    */
   public static func waitFor(app: XCUIApplication, testCase: XCTestCase, labelString: String, timeOut: Double = 5) {
      let label: XCUIElement = app.staticTexts[labelString] // Get the XCUIElement instance of the label with the provided string
      let exists: NSPredicate = .init(format: "exists == true") // Create a predicate to check if the label exists
      testCase.expectation( // Create an expectation for the label to exist
         for: exists, // The expectation to evaluate
         evaluatedWith: label, // The object to evaluate the expectation against
         handler: nil // The handler to call when the expectation is fulfilled
      ) 
      testCase.waitForExpectations( // Wait for the expectation to be fulfilled within the provided timeout
         timeout: timeOut, // The maximum amount of time to wait for the expectation to be fulfilled
         handler: nil // The handler to call when the expectation is fulfilled or times out
      )
      XCTAssert(label.exists) // Assert that the label exists
   }
   /**
    * ⚠️️ Beta ⚠️️
    * Waits for the provided XCUIElement to appear on the screen within the provided timeout.
    * - Description: Waits for the provided XCUIElement to appear on the screen within the provided timeout. This function adds an assertion to the provided XCTestCase instance to check that the element exists.
    * - Important: ⚠️️ This method supports optional elements, whereas the native method `element.waitForExistence(timeOut:)` wouldn't be able to evaluate it because the element is nil.
    * - Note: `wait(for:timeout:)` returns an `XCTestWaiterResult`, an enum representing the result of the test. It can be one of four possible values: `completed`, `timedOut`, `incorrectOrder`, or `invertedFulfillment`. Only the first, `completed`, indicates that the element was successfully found within the allotted timeout.
    * - Remark: A big advantage of this approach is that the test suite reads as a synchronous flow. There is no callback block or completion handler. The helper method simply returns a boolean indicating if the element appeared or not.
    * - Parameters:
    *   - element: The XCUIElement to wait for.
    *   - timeOut: The timeout in seconds to wait for the element to appear. Default is 5 seconds.
    * - Returns: A boolean indicating whether the element appeared within the provided timeout.
    * - Example:
    *   ```
    *   waitForElementToAppear(app.firstDescendant { $0.elementType == .table }, timeOut: 10)
    *   ```
    */
   public static func waitForElementToAppear(element: XCUIElement, timeOut: Double = 5) -> Bool {
      let existsPredicate: NSPredicate = .init(format: "exists == true") // Create a predicate to check if the element exists
      let expectation: XCTNSPredicateExpectation = .init(
         predicate: existsPredicate, // The predicate to evaluate
         object: element // The element to evaluate the predicate against
      ) // Create an expectation for the element to exist
      let waiter: XCTWaiter = .init() // Create a new XCTWaiter instance
      let result: XCTWaiter.Result = waiter.wait(
         for: [expectation], // The expectations to wait for
         timeout: timeOut // The maximum amount of time to wait for the expectations to be fulfilled
      ) // Wait for the expectation to be fulfilled within the provided timeout
      return result == .completed // Return a boolean indicating whether the element appeared within the provided timeout
   }
}
#endif
