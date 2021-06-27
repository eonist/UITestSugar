#if os(iOS)
import Foundation
import XCTest

/**
 * Assert
 */
extension XCUIElement {
   /**
    * Asert if exists and is visible in window
    * - Caution: ⚠️️ in some cases its visible but may be under neat something and thus isHittable returns false.
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
}

#endif
