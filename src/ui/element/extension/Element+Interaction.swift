import Foundation
import XCTest
/**
 * Text
 */
extension XCUIElement {
   /**
    * Removes any current text in the field before typing in the new value
    * - Parameter text: the text to enter into the field
    */
   public func clearAndTypeText(text: String) {
      ElementModifier.clearAndTypeText(element: self, text: text)
   }
}
/**
 * Scrolling
 */
extension XCUIElement {
   /**
    * Scrolling
    */
   public func scrollTo(dir: ElementModifier.Direction, searchCondition: ElementParser.MatchCondition) {
      ElementModifier.scrollTo(element: self, dir: dir, searchCondition: searchCondition)
   }
   /**
    * Scrolling (beta)
    */
   public func scrollToElement(element: XCUIElement) {
      ElementModifier.scrollToElement(parent: self, element: element)
   }
}
/**
 * Tapping
 */
extension XCUIElement {
   /**
    * Helps to tap things that don't work with regular .tap() calls. as .tap() calls must be on .isHittable items
    */
   public func forceTapElement() {
      if self.isHittable {
         self.tap()
      } else {
         let coordinate: XCUICoordinate = self.coordinate(withNormalizedOffset: .init(dx: 0.0, dy: 0.0))
         coordinate.tap()
      }
   }
   /**
    * Adds convenient way to tap and then wait for a duration (seconds)
    * - Abstract: It looks more natural to wait a bit after a tap
    * ## Examples:
    * app.buttons.firstMatch.tap(wait: 0.2)
    */
   public func tap(wait sec: Double) {
      self.tap()
      sleep(sec: sec)
   }
}
