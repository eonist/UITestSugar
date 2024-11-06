#if canImport(XCTest)
import Foundation
import XCTest
/**
 * Provides assertion methods for checking the visibility and existence of UI elements in a UI testing framework like XCUITest.
 */
extension XCUIElement {
   /**
    * Asserts if the element exists and is visible in the window.
    * - Description: This method checks if the UI element is both present and visible within the application's window. It waits up to the specified timeout for these conditions to be met. Visibility here means that the element is not only present in the UI hierarchy but also appears on the screen. However, it might still be obscured by other elements.
    * - Caution: ⚠️️ In some cases, the element may be visible but may be underneath something else, causing `isHittable` to return false.
    * - Parameter timeOut: The maximum amount of time to wait for the element to become visible.
    * - Returns: `true` if the element exists and is visible within the specified timeout, `false` otherwise.
    */
   public func doesExistAndIsVisible(timeOut: Double) -> Bool {
      ElementAsserter.existsAndVisible(
         element: self, // The element to check for existence and visibility
         timeout: timeOut // The maximum amount of time to wait for the element to be both existent and visible
      )
   }
   /**
    * Asserts if the element is currently visible on the screen.
    * - Description: This method checks if the element is visible within the application's window. It verifies that the element is not only present in the UI hierarchy but also not obscured by other elements, ensuring it can be seen by the user.
    * - Returns: `true` if the element is visible, `false` otherwise.
    */
   public var isVisible: Bool {
      ElementAsserter.isVisibleInWindow(element: self)
   }
   /**
    * Asserts if the element exists and is currently hittable.
    * - Description: This method checks if the element is present in the UI hierarchy and can be interacted with (hittable). An element is considered hittable if it is visible and not obscured by other elements, allowing user interaction such as tapping.
    * - Returns: `true` if the element exists and is hittable, `false` otherwise.
    */
   public var existsAndIsHittable: Bool {
      ElementAsserter.existsAndIsHittable(element: self)
   }
   /**
    * Returns the state of a `UISwitch` element.
    * - Description: This property determines whether a `UISwitch` is in the "on" position. It is particularly useful in UI testing scenarios where the state of a switch needs to be verified.
    * - Note: This property is useful for checking the state of a `UISwitch` element in a UI testing scenario.
    * - Returns: `true` if the switch is on, `false` otherwise.
    */
   public var isOn: Bool {
      (value as? String) == "1" // Check if the value is a string and equal to "1"
   }
}
#endif
