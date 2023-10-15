#if canImport(XCTest)
import Foundation
import XCTest
/**
 * Other
 * This extension provides additional convenience methods for XCUIElement.
 */
extension XCUIElement {
   /**
    * A convenient way to add some time after a call.
    * - Parameter sleepSecs: The number of seconds to sleep.
    * - Returns: The current XCUIElement instance.
    */
   @discardableResult public func wait(after sleepSecs: Double) -> XCUIElement {
      // Sleep for the specified number of seconds
      sleep(sec: sleepSecs)
      // Return the modified element
      return self
   }
   /**
    * Checks if an item exists and is hittable. If it's not hittable, then the app is tapped so that the tooltip goes away.
    * - Returns: The current XCUIElement instance.
    */
   @discardableResult public func disregardToolTip() -> XCUIElement {
      let elementExists = self.waitForExistence(timeout: 10)
      if elementExists && self.isHittable == false { // Most likely tooltip is being shown and this needs to be dismissed.
         XCUIApplication().tap(waitForExistence: 5, waitAfter: 2)
      }
      return self
   }
   /**
    * Same as adjust, but returns self for chaining calls.
    * - Remark: We can't use adjust as it's a native call.
    * - Parameter scalar: The scalar value to adjust the slider to.
    * - Returns: The current XCUIElement instance.
    */
   @discardableResult public func slide(_ scalar: CGFloat) -> XCUIElement {
      self.adjust(toNormalizedSliderPosition: scalar) // Adjust the slider to the normalized position specified by the scalar
      return self // Return the adjusted slider element
   }
}
#endif
