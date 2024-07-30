#if canImport(XCTest)
import Foundation
import XCTest
/**
 * Other
 * - Description: This extension provides additional convenience methods for XCUIElement.
 */
extension XCUIElement {
   /**
    * This method introduces a delay in the execution of the program. 
    * It is useful when you want to pause the execution for a certain period of time, 
    * for example, to wait for an animation to finish or for a network request to complete.
    * - Parameter sleepSecs: The duration of the delay in seconds.
    * - Returns: The current XCUIElement instance.
    */
   @discardableResult public func wait(after sleepSecs: Double) -> XCUIElement {
      sleep(sec: sleepSecs) // Sleep for the specified number of seconds
      return self // Return the modified element
   }
   /**
    * This method checks if the current XCUIElement exists and is interactable (hittable). 
    * If the element is not hittable, it is likely that a tooltip is obstructing it. 
    * In such cases, the method performs a tap action on the application to dismiss the tooltip.
    * - Returns: The current XCUIElement instance after performing the necessary actions.
    */
   @discardableResult public func disregardToolTip() -> XCUIElement {
      let elementExists: Bool = self.waitForExistence(timeout: 10)
      if elementExists && self.isHittable == false { // Most likely tooltip is being shown and this needs to be dismissed.
         XCUIApplication().tap(waitForExistence: 5, waitAfter: 2)
      }
      return self
   }
   /**
    * This method adjusts the slider to a specified scalar value and returns the current XCUIElement instance for chaining calls.
    * - Remark: We can't use the native 'adjust' call as it doesn't support chaining.
    * - Parameter scalar: The scalar value to which the slider should be adjusted. This value should be between 0 and 1, where 0 represents the minimum value of the slider and 1 represents the maximum value.
    * - Returns: The current XCUIElement instance after adjusting the slider.
    */
   @discardableResult public func slide(_ scalar: CGFloat) -> XCUIElement {
      self.adjust(toNormalizedSliderPosition: scalar) // Adjust the slider to the normalized position specified by the scalar
      return self // Return the adjusted slider element
   }
}
#endif
