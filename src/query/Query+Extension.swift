import Foundation
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
      return QueryHelper.hittableElements(query: self)
   }
}
/**
 * Query extension for element
 */
extension Optional where Wrapped == XCUIElement {
   /**
    * - Abstract: This method is needed because the native `.waitForExistence(timeOut:)` doesn't work on optional elements
    * ## Examples:
    * let didAppear: Bool = app.firstDescendant { $0.elementType == .table }.waitToAppear(10)
    */
   public func waitToAppear(_ timOut: Double = 5) -> Bool {
      return QueryAsserter.waitForElementToAppear(element: self, timeOut: timOut)
   }
   /**
    * - Remark: Great for chaining calls (where UI might not be ready because of network delays etc)
    * ## Examples:
    * app.firstDescendant { $0.elementType == .table }.waitToAppear(10).tap()
    */
   public func waitToAppear(_ timOut: Double = 5) -> XCUIElement? {
      _ = QueryAsserter.waitForElementToAppear(element: self, timeOut: timOut)
      return self
   }
}
