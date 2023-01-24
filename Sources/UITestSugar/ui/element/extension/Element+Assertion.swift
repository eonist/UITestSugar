#if canImport(XCTest)
import Foundation
import XCTest
/**
 * Assert
 */
extension XCUIElement {
   /**
    * Asert if exists and is visible in window
    * - Caution: ⚠️️ in some cases its visible but may be under neat something and thus isHittable returns false.
    * - Parameter timeOut: - Fixme: ⚠️️
    */
   public func doesExistAndIsVisible(timeOut: Double) -> Bool {
      ElementAsserter.existsAndVisible(element: self, timeout: timeOut)
   }
   /**
    * Asserts if an item is visible
    */
   public var isVisible: Bool { ElementAsserter.isVisibleInWindow(element: self) }
   /**
    * Indicates if the element is currently visible on the screen
    */
   public var existsAndIsHittable: Bool { ElementAsserter.existsAndIsHittable(element: self) }
   /**
    * - Note: Used for UISwitch ref: https://stackoverflow.com/questions/44222966/from-an-xcuitest-how-can-i-check-the-on-off-state-of-a-uiswitch
    * XCTAssert(activationSwitch.isOn == true)
    */
   public var isOn: Bool {
      (value as? String) == "1"
   }
}
#endif
