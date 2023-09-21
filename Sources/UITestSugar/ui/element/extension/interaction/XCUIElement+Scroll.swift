#if canImport(XCTest)
import Foundation
import XCTest
/**
 * Extension for scrolling XCUIElement objects.
 */
extension XCUIElement {
   /**
    * Scrolls the element in the specified direction until the search condition is met.
    * - Parameters:
    *   - dir: The direction in which to scroll.
    *   - searchCondition: The condition to search for.
    * - Returns: The same XCUIElement object.
    */
   @discardableResult public func scrollTo(dir: ElementModifier.Direction, searchCondition: ElementParser.MatchCondition) -> XCUIElement {
      // Scroll the element in the specified direction until the search condition is met
      ElementModifier.scrollTo(element: self, dir: dir, searchCondition: searchCondition)
      // Return the modified element
      return self
   }
   /**
    * Scrolls the parent element until the specified child element is visible.
    * - Parameters:
    *   - element: The child element to scroll to.
    *   - dir: The direction in which to scroll.
    * - Returns: The same XCUIElement object.
    */
   @discardableResult public func scrollToElement(element: XCUIElement, dir: ElementModifier.Direction = .up) -> XCUIElement {
      // Scroll the parent element in the specified direction until the child element is visible
      ElementModifier.scrollToElement(parent: self, element: element, dir: dir)
      // Return the modified element
      return self
   }
   /**
    * Scrolls the element until the search condition is met.
    * - Parameter searchCondition: The condition to search for.
    * - Returns: The same XCUIElement object.
    */
   @discardableResult public func scrollTo(searchCondition: ElementParser.MatchCondition) -> XCUIElement {
      // Scroll the element in the specified direction until the search condition is met
      ElementModifier.scrollToElement(element: self, searchCondition: searchCondition)
      // Return the modified element
      return self
   }
}
#endif