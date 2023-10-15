#if canImport(XCTest)
import Foundation
import XCTest
/**
 * Tapping
 */
extension XCUIElement {
   /**
    * Helps to tap things that doesn't work with regular `.tap()` calls. as `.tap()` calls must be on .isHittable items
    * - Description: Taps the element, even if it is not currently hittable.
    * - Caution: ⚠️️ If you use this method in conjunction with: `.isVisibleInWindow` call. This method can still fail. If something is covering the element or is slightly within window etc
    * - Returns: The same XCUIElement object.
    */
   @discardableResult public func forceTapElement() -> XCUIElement {
      if self.isHittable {
         self.tap() // Taps the element if it is hittable
      } else {
         // - Fixme: ⚠️️ this might be broken
         let offset: CGPoint = .zero // Calculates the center point of the element
         let coordinate: XCUICoordinate = self.coordinate(withNormalizedOffset: .init(dx: offset.x, dy: offset.y)) // Gets the coordinate of the center point
         coordinate.tap() // Taps the coordinate of the center point
      }
      return self // Returns the element after tapping it
   }
   /**
    * Taps the element, with optional wait time before and after the tap.
    * - Remark: This method may work better for macOS.
    * - Parameters:
    *   - waitForExistence: The maximum time to wait for the element to exist before tapping it.
    *   - waitAfter: The time to wait after tapping the element.
    * - Returns: The same XCUIElement object.
    */
   @discardableResult public func forceTap(waitForExistence: Double = 5, waitAfter: Double = 0.2) -> XCUIElement {
      guard self.waitForExistence(timeout: waitForExistence) else { return self } // Wait for the element to exist
      let vector: CGVector = .init(dx: 0.5, dy: 0.5) // Set the vector
      self.coordinate(withNormalizedOffset: vector).tap() // Tap the element
      return self.wait(after: waitAfter) // Wait for the element to load
   }
   /**
    * Taps the element and waits for a specified duration.
    * - Description: This method provides a convenient way to tap and then wait for a duration (in seconds).
    * - Example: `app.buttons.firstMatch.tap(waitAfter: 0.2)`
    * - Parameter sec: The time to wait after tapping the element.
    * - Returns: The same XCUIElement object.
    */
   @discardableResult public func tap(waitAfter sec: Double) -> XCUIElement {
      // Tap the element
      self.tap() // Wait for the specified amount of time after the tap
      return self.wait(after: sec)
   }
   /**
    * Wait for existence then tap
    * - Remark: `waitForExistence` is a natice call
    * ## Examples:
    * app.buttons.firstMatch.tap(waitForExistence: 0.2)
    * - Parameter sec: - Fixme: ⚠️️ doc
    */
   @discardableResult public func tap(waitForExistence sec: Double) -> XCUIElement? {
      guard self.waitForExistence(timeout: sec) else {
         // If the element does not exist within the specified timeout, return nil
         return nil
      }
      self.tap()
      return self
   }
   /**
    * Wait for the element to exist within the specified timeout, then tap the element, and wait for the specified amount of time.
    * ## Examples:
    * ```
    * // Tap the first button element that appears within 0.2 seconds of waiting for its existence, then wait for 2 seconds
    * app.buttons.firstMatch.tap(waitForExistence: 0.2, waitAfter: 2.0)
    * ```
    * - Parameters:
    *   - secs: The maximum amount of time to wait for the element to exist.
    *   - sleepSecs: The amount of time to wait after tapping the element.
    * - Returns: The tapped element, or `nil` if it does not exist within the specified timeout.
    */
   @discardableResult public func tap(waitForExistence secs: Double, waitAfter sleepSecs: Double) -> XCUIElement? {
      guard self.waitForExistence(timeout: secs) else { return nil } // Wait for the element to exist within the specified timeout
      self.tap() // Tap the element on iOS/macOS
      return self.wait(after: sleepSecs) // Wait for the specified amount of time after the tap
   }
}
#endif
