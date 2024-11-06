#if canImport(XCTest)
import Foundation
import XCTest
/**
 * Tapping
 */
extension XCUIElement {
   /**
    * This method is designed to tap elements that are not responsive to the standard `.tap()` call, as `.tap()` requires elements to be .isHittable.
    * - Description: This method attempts to tap the element regardless of its current hittability status.
    * - Caution: ⚠️️ If this method is used in conjunction with the `.isVisibleInWindow` call, it may still fail. This can occur if an element is obstructed or only partially within the window.
    * - Returns: The same XCUIElement object after the tap attempt.
    */
   @discardableResult public func forceTapElement() -> XCUIElement {
      if self.isHittable {
         self.tap() // Taps the element if it is hittable
      } else {
         // - Fixme: ⚠️️ this might be broken
         let offset: CGPoint = .zero // Calculates the center point of the element
         let coordinate: XCUICoordinate = self.coordinate(
            withNormalizedOffset: .init(
               dx: offset.x, // The x-coordinate offset from the center of the element
               dy: offset.y // The y-coordinate offset from the center of the element
            )
         ) // Gets the coordinate of the center point
         coordinate.tap() // Taps the coordinate of the center point
      }
      return self // Returns the element after tapping it
   }
   /**
    * Executes a tap action on the element, with the ability to specify a wait time before and after the tap.
    * - Remark: This method may be more effective for macOS.
    * - Parameters:
    *   - waitForExistence: The maximum duration (in seconds) to wait for the element to become available before executing the tap action.
    *   - waitAfter: The duration (in seconds) to pause execution after the tap action has been performed.
    * - Returns: The same XCUIElement instance, allowing for method chaining.
    */
   @discardableResult public func forceTap(waitForExistence: Double = 5, waitAfter: Double = 0.2) -> XCUIElement {
      guard self.waitForExistence(timeout: waitForExistence) else {
         return self
      } // Wait for the element to exist
      let vector: CGVector = .init(dx: 0.5, dy: 0.5) // Set the vector
      self.coordinate(withNormalizedOffset: vector).tap() // Tap the element
      return self.wait(after: waitAfter) // Wait for the element to load
   }
   /**
    * Executes a tap action on the element and then pauses execution for a specified duration.
    * - Description: This method is useful when you want to simulate user interaction with the UI and then wait for a certain period of time, for example, to allow for animations to complete or for the UI to update. The duration of the pause is specified in seconds.
    * - Example: `app.buttons.firstMatch.tap(waitAfter: 0.2)` This example taps the first matching button element and then pauses execution for 0.2 seconds.
    * - Parameter sec: The duration of the pause in seconds.
    * - Returns: The same XCUIElement instance, allowing for method chaining.
    */
   @discardableResult public func tap(waitAfter sec: Double) -> XCUIElement {
      // Tap the element
      self.tap() // Wait for the specified amount of time after the tap
      return self.wait(after: sec)
   }
   /**
    * Taps the element after waiting for its existence.
    * - Description: This method waits for the element to exist within the specified timeout before performing a tap action. If the element does not exist within the timeout, the tap action is not performed.
    * - Remark: `waitForExistence` is a native XCTest call that waits for the element to exist within the specified timeout.
    * - Parameter waitForExistence: The maximum amount of time, in seconds, to wait for the element to exist before performing the tap action.
    * ## Examples:
    * ```
    * // Taps the first button element that appears within 0.2 seconds of waiting for its existence
    * app.buttons.firstMatch.tap(waitForExistence: 0.2)
    * ```
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
    * This method performs a tap action on the element after ensuring its existence within a specified timeout. It then introduces a delay for a specified duration after the tap action.
    * - Description: This method is useful when you want to simulate user interaction with the UI and then wait for a certain period of time, for example, to allow for animations to complete or for the UI to update. The duration of the pause is specified in seconds.
    * - Example: 
    * ```
    * // This example waits for the first button element to appear within 0.2 seconds, taps it, and then pauses execution for 2 seconds.
    * app.buttons.firstMatch.tap(waitForExistence: 0.2, waitAfter: 2.0)
    * ```
    * - Parameters:
    *   - secs: The maximum duration (in seconds) to wait for the element to become available before executing the tap action.
    *   - sleepSecs: The duration (in seconds) to pause execution after the tap action has been performed.
    * - Returns: The same XCUIElement instance after performing the tap action and the delay, or `nil` if the element does not become available within the specified timeout.
    */
   @discardableResult public func tap(waitForExistence secs: Double, waitAfter sleepSecs: Double) -> XCUIElement? {
      guard self.waitForExistence(timeout: secs) else {
         return nil
      } // Wait for the element to exist within the specified timeout
      self.tap() // Tap the element on iOS/macOS
      return self.wait(after: sleepSecs) // Wait for the specified amount of time after the tap
   }
}
#endif
