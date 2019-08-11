import Foundation
import XCTest
/**
 * Scrolling
 */
extension ElementModifier {
   /**
    * Search down a scroll view until searchCondition is met (⚠️️ Beta ⚠️️)
    * - Parameter element: The root to search from
    * - Parameter dir: Use .up for scrolling a list to the last item in the list, use .down to scroll the list to first item
    * - Parameter searchCondition:
    * ## Examples:
    * let condA: ElementParser.MatchCondition = { $0.title == "Featured playlist" }
    * let condB: ElementParser.MatchCondition = { $0.identifier == "Featured Playlists-View all" }
    * scrollTo(root: app, dir: .up, searchCondition: { ElementParser.firstDescendant(element: $0, condition: condA) && ElementParser.firstDescendant(element: $0, condition: condB) })
    */
   public static func scrollTo(element: XCUIElement, dir: Direction, searchCondition: ElementParser.MatchCondition) {
      while !searchCondition(element) {
         dir == .up ? element.swipeUp() : element.swipeDown()
      }
   }
   
}
/**
 * Beta
 */
extension ElementModifier {
   /**
    * Scrolls until element is visible
    * - Parameter parent: the element to swipe
    * - Parameter element: the element to swipe to
    * - Parameter dir: Use .up for scrolling a list to the last item in the list, use .down to scroll the list to first item
    * - Note: try to set cells: cell.accessibilityIdentifer = "cell \(indexPath.row)"
    * - Note: there is also Native: firstScrollView.scrollToElement(element: seventhChild)
    */
   public static func scrollToElement(parent: XCUIElement, element: XCUIElement, dir: Direction = .up) {
      while !ElementAsserter.isVisibleInWindow(element: element) {
         dir == .up ? element.swipeUp() : element.swipeDown()
      }
   }
   /**
    * Search down a scroll view until it finds a certain element (⚠️️ Beta ⚠️️)
    * - Note: there is also: firstScrollView.scrollToElement(element: seventhChild)
    * - Parameter element: Can be the app
    */
   public static func scrollDownUntilFound(element: XCUIElement, id: String, type: XCUIElement.ElementType, timeOut: Double = 10) {
      var exists: Bool = false
      repeat {
         let element: XCUIElement = element.descendants(matching: type).element(matching: type, identifier: id).firstMatch
         exists = ElementAsserter.exists(element: element, timeout: timeOut)
         if exists { element.swipeUp() } // no need to swipeUp if found
      } while !exists
   }
}
/**
 * Type For scrolling methods
 */
extension ElementModifier {
   public enum Direction { case up, down }
}