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
    * Helps to tap things that doesn't work with regular .tap() calls. as .tap() calls must be on .isHittable items
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
    * - Abstract: It's more natural to wait a bit after a tap
    * ## Examples:
    * app.buttons.firstMatch.tap(waitAfter: 0.2)
    */
   public func tap(waitAfter sec: Double) {
      self.tap()
      sleep(sec: sec)
   }
   /**
    * Wait for existence then tap
    * ## Examples:
    * app.buttons.firstMatch.tap(waitForExistance: 0.2)
    */
   public func tap(waitForExistance sec: Double) {
      _ = self.waitForExistence(timeout: sec)
      self.tap()
   }
   /**
    * Wait for existence, then tap, then sleep
    * ## Examples:
    * app.buttons.firstMatch.tap(waitForExistance: 0.2, waitAfter: 2.0)
    */
   public func tap(waitForExistance secs: Double, waitAfter sleepSecs: Double) {
      _ = self.waitForExistence(timeout: secs)
      self.tap()
      sleep(sec: sleepSecs)
   }
}
