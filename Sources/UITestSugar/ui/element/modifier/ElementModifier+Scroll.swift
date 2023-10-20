#if canImport(XCTest)
import Foundation
import XCTest
/**
 * Scrolling
 */
extension ElementModifier {
   /**
    * Searches down a scroll view until `searchCondition` is met.
    * - Parameters:
    *   - element: The root element to search from.
    *   - dir: The direction to scroll in.
    *   - searchCondition: A closure that takes an `XCUIElement` and returns a `Bool`. The closure is used to check if an element being searched has a certain condition.
    * ## Example:
    * // Scroll down a list until the first item with a title of "Featured playlist" and an identifier of "Featured Playlists-View all" is found
    * let condA: ElementParser.MatchCondition = { $0.title == "Featured playlist" }
    * let condB: ElementParser.MatchCondition = { $0.identifier == "Featured Playlists-View all" }
    * scrollTo(element: app, dir: .down, searchCondition: { ElementParser.firstDescendant(element: $0, condition: condA) && ElementParser.firstDescendant(element: $0, condition: condB) })
    */
   public static func scrollTo(element: XCUIElement, dir: Direction, searchCondition: ElementParser.MatchCondition) {
      // Keep scrolling until the search condition is met
      while !searchCondition(element) {
         switch dir { // Perform a swipe in the specified direction
            case .up: element.swipeUp() // Swipe up
            case .down: element.swipeDown() // Swipe down
            case .left: element.swipeLeft() // Swipe left
            case .right: element.swipeRight() // Swipe right
         }
      }
   }
}
/**
 * Beta
 */
extension ElementModifier {
   /**
    * Scrolls until `element` is visible.
    * - Remark: Try to set cells: `cell.accessibilityIdentifer = "cell \(indexPath.row)"`
    * - Remark: There is also a native function `firstScrollView.scrollToElement(element: seventhChild)` that can be used to scroll to an element.
    * - Parameters:
    *   - parent: The element to swipe.
    *   - element: The element to swipe to.
    *   - dir: The direction to swipe in. Use `.up` for scrolling a list to the last item in the list, use `.down` to scroll the list to the first item.
    */
   public static func scrollToElement(parent: XCUIElement, element: XCUIElement, dir: Direction = .up) {
      while !ElementAsserter.isVisibleInWindow(element: element) { // While the element is not visible
         // Swipe up or down depending on the direction
         if dir == .up {
            element.swipeUp()
         } else {
            element.swipeDown()
         } 
      }
   }
   /**
    * Searches down a scroll view until it finds a certain element.
    * - Remark: There is also a similar function `firstScrollView.scrollToElement(element: seventhChild)` that can be used to scroll to an element.
    * - fix: since we already matched the type, we could just match id
    * - Parameters:
    *   - element: The root element to search from.
    *   - id: The identifier of the element being searched for.
    *   - type: The type of UI element being searched for.
    *   - timeOut: The maximum amount of time to wait for the element to be found. Default is 10 seconds.
    */
   public static func scrollDownUntilFound(element: XCUIElement, id: String, type: XCUIElement.ElementType, timeOut: Double = 10) {
      var exists = false // Initialize a boolean variable to keep track of whether the element exists or not
      repeat { // Repeat the following block until the condition is met
         // Get all descendants of the element that match the specified type
         let elementQuery: XCUIElementQuery = element.descendants(matching: type)
         // Get the descendant element with the specified identifier and type
         let element: XCUIElement = elementQuery.element(
            matching: type, // The type of element to search for
            identifier: id // The identifier of the element to search for
         )
         // Find the first descendant that matches the specified search types and identifier
         let match: XCUIElement = element.firstMatch
         exists = ElementAsserter.exists(element: match, timeout: timeOut) // Check if the element exists within the specified timeout
         if exists { element.swipeUp() } // If the element exists, swipe up to stop searching
      } while !exists // Repeat until the element is found
   }
}
/**
 * Type For scrolling methods
 */
extension ElementModifier {
   public enum Direction { // Define an enumeration for the scrolling direction
      case up // Swipe up
      case down // Swipe down
      case left // Swipe left
      case right // Swipe right
   }
}
/**
 * Beta
 */
extension ElementModifier {
   /**
    * Scrolls to a particular element until it is rendered in the visible rect.
    * - Note: https://gist.github.com/ryanmeisters/f4e961731db289f489e1a08183e334d9 (The selected link is a GitHub Gist that provides an example of how to scroll to an element in a table view using UI testing in Xcode.)
    * - Note: https://stackoverflow.com/questions/32646539/scroll-until-element-is-visible-ios-ui-automation-with-xcode7 (The selected link is a Stack Overflow post that provides a solution for scrolling until an element is visible in iOS UI automation with Xcode 7)
    * - Parameters:
    *   - element: The element to scroll to.
    *   - searchCondition: A closure that takes an `XCUIElement` and returns a `Bool`. The closure is used to check if an element being searched has a certain condition.
    * - Fixme: ⚠️️ which dir? The direction of the swipe is not specified in the code.
    * - Fixme: ⚠️️ doc. The second parameter is named `element` instead of `searchCondition`.
    */
   public static func scrollToElement(element: XCUIElement, searchCondition: ElementParser.MatchCondition) {
      // Scroll the element until the search condition is met
      while !searchCondition(element) {
         // Get the center coordinate of the element
         let startCoord: XCUICoordinate = element.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
         // Get the coordinate of the element after scrolling
         let endCoord: XCUICoordinate = startCoord.withOffset(CGVector(dx: 0.0, dy: -262))
         // Press and drag the element to scroll it
         startCoord.press(forDuration: 0.01, thenDragTo: endCoord)
      }
   }
}
#endif
