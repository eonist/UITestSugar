import Foundation
#if canImport(XCTest)
import XCTest
/**
 * Query extension for element
 */
extension XCUIElement {
   /**
   * Waits for the element to appear on the screen.
   * 
   * - Description: This method is needed because the native `.waitForExistence(timeOut:)` doesn't work on optional elements.
   * - Remark: We had to change the name to something different than `waitToAppear`, or else chaining would be ambiguous.
   * - Fixme: ⚠️️ You could implement the native `waitForExistence` call and then just return the element.
   * - Fixme: ⚠️️ Make this not require result.
   * 
   * - Parameter timeOut: The maximum amount of time to wait for the element to appear, in seconds. Defaults to 5 seconds.
   * 
   * - Returns: `true` if the element appears within the specified time, `false` otherwise.
   * 
   * ## Example:
   * ```
   * let app = XCUIApplication()
   * let table = app.firstDescendant { $0.elementType == .table }
   * let didAppear = table.waitForAppearance(10)
   * ```
   */
   public func waitForAppearance(_ timeOut: Double = 5) -> Bool {
      QueryAsserter.waitForElementToAppear(element: self, timeOut: timeOut)
   }
   /**
   * Waits for the element to appear on the screen.
   * 
   * - Description: This method is needed because the native `.waitForExistence(timeOut:)` doesn't work on optional elements.
   * - Remark: We had to change the name to something different than `waitToAppear`, or else chaining would be ambiguous.
   * - Fixme: ⚠️️ You could implement the native `waitForExistence` call and then just return the element.
   * - Fixme: ⚠️️ Make this not require result.
   * 
   * - Parameter timeOut: The maximum amount of time to wait for the element to appear, in seconds. Defaults to 5 seconds.
   * 
   * - Returns: `true` if the element appears within the specified time, `false` otherwise.
   * 
   * ## Example:
   * ```
   * let app = XCUIApplication()
   * let table = app.firstDescendant { $0.elementType == .table }
   * let didAppear = table.waitForAppearance(10)
   * ```
   */
   public func waitToAppear(_ timeOut: Double = 5) -> XCUIElement? {
      _ = QueryAsserter.waitForElementToAppear(element: self, timeOut: timeOut)
      return self
   }
}
#endif
