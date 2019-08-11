import Foundation
import XCTest

/**
 * Assert
 */
extension XCUIElement {
   /**
    * Asert if exists and is visible in window
    */
   public func doesExistAndIsVisible(timeOut: Double) -> Bool {
      return ElementAsserter.existsAndVisible(element: self, timeout: timeOut)
   }
   /**
    * Asserts if an item is visible
    */
   public var isVisible: Bool { return ElementAsserter.isVisibleInWindow(element: self) }
}
