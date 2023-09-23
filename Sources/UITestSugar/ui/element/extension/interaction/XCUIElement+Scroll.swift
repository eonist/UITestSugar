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
      ElementModifier.scrollTo(element: self, dir: dir, searchCondition: searchCondition)// Scroll the element in the specified direction until the search condition is met
      return self// Return the modified element
   }
   /**
    * Scrolls the parent element until the specified child element is visible.
    * - Parameters:
    *   - element: The child element to scroll to.
    *   - dir: The direction in which to scroll.
    * - Returns: The same XCUIElement object.
    */
   @discardableResult public func scrollToElement(element: XCUIElement, dir: ElementModifier.Direction = .up) -> XCUIElement {
      ElementModifier.scrollToElement(parent: self, element: element, dir: dir) // Scroll the parent element in the specified direction until the child element is visible
      return self // Return the modified element
   }
   /**
    * Scrolls the element until the search condition is met.
    * - Parameter searchCondition: The condition to search for.
    * - Returns: The same XCUIElement object.
    */
   @discardableResult public func scrollTo(searchCondition: ElementParser.MatchCondition) -> XCUIElement {
      ElementModifier.scrollToElement(element: self, searchCondition: searchCondition) // Scroll the element in the specified direction until the search condition is met
      return self // Return the modified element
   }
}
#endif