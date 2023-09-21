#if canImport(XCTest)
import Foundation
import XCTest
/**
 * Provides assertion methods for checking the visibility and existence of UI elements in a UI testing framework like XCUITest.
 */
extension XCUIElement {
   /**
    * Asserts if the element exists and is visible in the window.
    * - Caution: ⚠️️ In some cases, the element may be visible but may be underneath something else, causing `isHittable` to return false.
    * - Parameter timeOut: The maximum amount of time to wait for the element to become visible.
    * - Returns: `true` if the element exists and is visible within the specified timeout, `false` otherwise.
    */
   public func doesExistAndIsVisible(timeOut: Double) -> Bool {
      ElementAsserter.existsAndVisible(element: self, timeout: timeOut)
   }
   /**
    * Asserts if the element is currently visible on the screen.
    * - Returns: `true` if the element is visible, `false` otherwise.
    */
   public var isVisible: Bool { ElementAsserter.isVisibleInWindow(element: self) }
   /**
    * Asserts if the element exists and is currently hittable.
    * - Returns: `true` if the element exists and is hittable, `false` otherwise.
    */
   public var existsAndIsHittable: Bool { ElementAsserter.existsAndIsHittable(element: self) }
   /**
    * Returns the state of a `UISwitch` element.
    * - Note: This property is useful for checking the state of a `UISwitch` element in a UI testing scenario.
    * - Returns: `true` if the switch is on, `false` otherwise.
    */
   public var isOn: Bool {
      (value as? String) == "1"
   }
}
#endif