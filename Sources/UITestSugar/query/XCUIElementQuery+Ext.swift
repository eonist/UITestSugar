import Foundation

#if canImport(XCTest)
import XCTest

/**
 * Extension to XCUIElementQuery that provides additional functionality.
 */
extension XCUIElementQuery {
   
   /**
    * Returns all descendants of a query that are currently visible and can be interacted with.
    * - Returns: An array of XCUIElement objects that are currently hittable.
    * - Example: `XCUIApplication().descendants(matching: .any).hittableElements.count` returns the number of hittable elements.
    */
   public var hittableElements: [XCUIElement] {
      QueryHelper.hittableElements(query: self)
   }
}
#endif