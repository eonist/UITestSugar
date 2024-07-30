#if canImport(XCTest)
import Foundation
import XCTest
/**
 * Extension for scrolling XCUIElement objects.
 */
extension XCUIElement {
   /**
    * This method scrolls the current XCUIElement in a specified direction until a given condition is satisfied.
    * - Parameters:
    *   - dir: The direction to scroll. This can be up, down, left, or right.
    *   - searchCondition: A closure that defines the condition to be met for the scrolling to stop. This closure takes an XCUIElement as its parameter and returns a Boolean value indicating whether the condition is satisfied.
    * - Returns: The same XCUIElement object after the scrolling action. This allows for method chaining.
    */
   @discardableResult public func scrollTo(dir: ElementModifier.Direction, searchCondition: ElementParser.MatchCondition) -> XCUIElement {
      ElementModifier.scrollTo(
         element: self, // The element to scroll to
         dir: dir, // The direction to scroll in
         searchCondition: searchCondition // The condition that must be met for the scrolling to stop
      ) // Scroll the element in the specified direction until the search condition is met
      return self// Return the modified element
   }
   /**
    * This method scrolls the current XCUIElement (parent) until a specified child element becomes visible on the screen.
    * - Parameters:
    *   - element: The child XCUIElement that needs to be visible on the screen.
    *   - dir: The direction to scroll. This can be up, down, left, or right.
    * - Returns: The same XCUIElement object after the scrolling action. This allows for method chaining.
    */
   @discardableResult public func scrollToElement(element: XCUIElement, dir: ElementModifier.Direction = .up) -> XCUIElement {
      ElementModifier.scrollToElement(
         parent: self, // The parent element to scroll within
         element: element, // The element to scroll to
         dir: dir // The direction to scroll in
      ) // Scroll the parent element in the specified direction until the child element is visible
      return self // Return the modified element
   }
   /**
    * This method scrolls the current XCUIElement until a specified condition is met.
    * - Parameter searchCondition: A closure that defines the condition to be met for the scrolling to stop. This closure takes an XCUIElement as its parameter and returns a Boolean value indicating whether the condition is satisfied.
    * - Returns: The same XCUIElement object after the scrolling action. This allows for method chaining.
    */
   @discardableResult public func scrollTo(searchCondition: ElementParser.MatchCondition) -> XCUIElement {
      ElementModifier.scrollToElement(
         element: self, // The element to scroll to
         searchCondition: searchCondition // The condition that must be met for the scrolling to stop
      ) // Scroll the element in the specified direction until the search condition is met
      return self // Return the modified element
   }
}
#endif
