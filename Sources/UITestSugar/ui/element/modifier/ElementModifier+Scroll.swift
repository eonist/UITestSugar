#if canImport(XCTest)
import Foundation
import XCTest
/**
 * Scrolling
 */
extension ElementModifier {
   /**
    * Scrolls within a scrollable element until a specified condition is met.
    * This method continuously scrolls in a given direction until an element that satisfies the `searchCondition` is found.
    * - Parameters:
    *   - element: The root element from which the scrolling starts.
    *   - dir: The direction in which to scroll (`up`, `down`, `left`, `right`).
    *   - searchCondition: A closure that evaluates an `XCUIElement` and returns a `Bool`. This closure is used to determine if the desired element has been found based on specific conditions.
    * ## Example:
    * // Example usage: Scroll down a list until an item with a specific title and identifier is found.
    * let conditionForTitle: ElementParser.MatchCondition = { $0.title == "Featured playlist" }
    * let conditionForIdentifier: ElementParser.MatchCondition = { $0.identifier == "Featured Playlists-View all" }
    * scrollTo(element: app, dir: .down, searchCondition: { ElementParser.firstDescendant(element: $0, condition: conditionForTitle) && ElementParser.firstDescendant(element: $0, condition: conditionForIdentifier) })
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
    * Scrolls the parent element until the specified child element is visible on the screen.
    * This method performs a series of swipe actions in the specified direction until the child element becomes visible within the parent element's viewport.
    * - Remark: Ensure that cells have unique accessibility identifiers, e.g., `cell.accessibilityIdentifier = "cell \(indexPath.row)"`
    * - Remark: Alternatively, the native function `firstScrollView.scrollToElement(element: seventhChild)` can be used for a similar purpose.
    * - Parameters:
    *   - parent: The scrollable element within which the swiping will occur.
    *   - element: The target element that needs to be visible after scrolling.
    *   - dir: The direction to swipe. Use `.up` to scroll towards the end of the content, and `.down` to scroll towards the beginning of the content.
    */
   public static func scrollToElement(parent: XCUIElement, element: XCUIElement, dir: Direction = .up) {
      while !ElementAsserter.isVisibleInWindow(element: element) { // While the element is not visible
         // Swipe up or down depending on the direction
         if dir == .up { // Check if the direction is upwards
            parent.swipeUp() // Perform an upward swipe on the parent element
         } else { // If the direction is not upwards
            parent.swipeDown() // Perform a downward swipe on the parent element
         } 
      }
   }
   /**
    * Continuously scrolls down within a scroll view until a specified element is located.
    * This method scrolls through the content of a scroll view, searching for an element that matches the given identifier and type. It stops scrolling once the element is found or the timeout expires.
    * - Remark: For a similar functionality with predefined elements, consider using `firstScrollView.scrollToElement(element: seventhChild)`.
    * - Note: This function optimizes the search by directly matching the identifier since the type is already specified.
    * - Fixme: ⚠️️ since we already matched the type, we could just match id?
    * - Parameters:
    *   - element: The root element from which the scrolling starts.
    *   - id: The identifier of the target element to find.
    *   - type: The type of the UI element being searched for.
    *   - timeOut: The maximum duration in seconds to attempt finding the element, with a default of 10 seconds.
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
 * Enumerates the possible directions for scrolling actions within UI tests.
 * This enumeration defines the directions in which an element can be scrolled, including vertical and horizontal movements.
 */
extension ElementModifier {
   public enum Direction {
      case up // Represents a swipe action moving upwards.
      case down // Represents a swipe action moving downwards.
      case left // Represents a swipe action moving to the left.
      case right // Represents a swipe action moving to the right.
   }
}
/**
 * Beta
 */
extension ElementModifier {
   /**
    * Scrolls to a particular element until it is rendered in the visible rect.
    * This method performs a scroll action to bring the specified element into the visible area of the app's interface. It continues to scroll until the `searchCondition` closure returns `true`, indicating that the desired visibility condition has been met.
    * - Note: For implementation examples, see:
    *   - https://gist.github.com/ryanmeisters/f4e961731db289f489e1a08183e334d9 (Example of scrolling to an element in a table view using UI testing in Xcode.)
    *   - https://stackoverflow.com/questions/32646539/scroll-until-element-is-visible-ios-ui-automation-with-xcode7 (Discussion on scrolling until an element is visible in iOS UI automation with Xcode 7)
    * - Parameters:
    *   - element: The element to which the method will scroll.
    *   - searchCondition: A closure that evaluates whether the specified element meets a certain condition. It takes an `XCUIElement` as its parameter and returns a `Bool`.
    * - Fixme: ⚠️️ The direction of the swipe is not specified in the code. Consider adding a parameter to specify the direction.
    * - Fixme: ⚠️️ The documentation for the second parameter should correctly reflect its purpose and name.
    */
   public static func scrollToElement(element: XCUIElement, searchCondition: ElementParser.MatchCondition) {
      // Continuously scroll until the search condition is satisfied
      while !searchCondition(element) {
         // Calculate the start and end coordinates for the scroll action
         let startCoord: XCUICoordinate = element.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
         let endCoord: XCUICoordinate = startCoord.withOffset(CGVector(dx: 0.0, dy: -262))
         // Perform the scroll action by dragging from start to end coordinate
         startCoord.press(forDuration: 0.01, thenDragTo: endCoord)
      }
   }
}
#endif
