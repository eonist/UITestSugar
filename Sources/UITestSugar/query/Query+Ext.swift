import Foundation
#if canImport(XCTest)
import XCTest
/**
 * Extension
 * - Fixme: ⚠️️ Rename to XCUIElementQuery+Ext?
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
/**
 * Query extension for element
 */
extension XCUIElement {
   /**
    * - Description: This method is needed because the native `.waitForExistence(timeOut:)` doesn't work on optional elements
    * - Remark: We had to change the name to something different than waitToAppear, or else chaining would be ambigouse
    * - Fixme: ⚠️️ you could implement the: native: waitForExistence call and the just return the element
    * - Fixme: ⚠️️ Make this not require result
    * ## Examples:
    * let didAppear: Bool = app.firstDescendant { $0.elementType == .table }.waitForAppearance(10)
    * - Parameter timeOut: - Fixme: ⚠️️ add doc
    */
   public func waitForAppearance(_ timeOut: Double = 5) -> Bool {
      QueryAsserter.waitForElementToAppear(element: self, timeOut: timeOut)
   }
   /**
    * - Remark: Great for chaining calls (where UI might not be ready because of network delays etc)
    * - Fixme: ⚠️️ Make this not require result
    * ## Examples:
    * app.firstDescendant { $0.elementType == .table }.waitToAppear(10).tap()
    * - Parameter timeOut: - Fixme: ⚠️️ add doc
    */
   public func waitToAppear(_ timeOut: Double = 5) -> XCUIElement? {
      _ = QueryAsserter.waitForElementToAppear(element: self, timeOut: timeOut)
      return self
   }
}
#endif
