import Foundation
import XCTest
/**
 * Scrolling
 */
extension ElementModifier {
   /**
    * Scrolls until element is visible
    * - Parameter parent: the element to swipe
    * - Parameter element: the element to swipe to
    * - Note: try to set cells: cell.accessibilityIdentifer = "cell \(indexPath.row)"
    * - Note: there is also Native: firstScrollView.scrollToElement(element: seventhChild)
    */
   public static func scrollToElement(parent: XCUIElement, element: XCUIElement) {
      while !ElementAsserter.isVisibleInWindow(element: element) {
         parent.swipeUp()
      }
   }
   /**
    * Search down a scroll view until searchCondition is met (⚠️️ Beta ⚠️️)
    * - Parameter element: The root to search from
    * - Parameter searchCondition:
    * ## Examples:
    * let condA: ElementParser.MatchCondition = { $0.title == "Featured playlist" }
    * let condB: ElementParser.MatchCondition = { $0.identifier == "Featured Playlists-View all" }
    * scrollTo(root: app, searchCondition: { ElementParser.firstDescendant(element: $0, condition: condA) && ElementParser.firstDescendant(element: $0, condition: condB) })
    */
   public static func scrollTo(element: XCUIElement, searchCondition: ElementParser.MatchCondition) {
      while !searchCondition(element) {
         element.swipeUp()
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
