import Foundation
#if canImport(XCTest)
import XCTest
/**
 * Extension
 */
extension XCUIElementQuery {
   /**
    * Returns all descendants of a query that are hittable
    * ## Examples:
    * XCUIApplication().descendants(matching: .any).hittableElements.count // n
    */
   public var hittableElements: [XCUIElement] {
      QueryHelper.hittableElements(query: self)
   }
}
#endif
