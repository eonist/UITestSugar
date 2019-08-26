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
   @discardableResult
   public func clearAndTypeText(text: String) -> XCUIElement {
      ElementModifier.clearAndTypeText(element: self, text: text)
      return self
   }
   /**
    * Same as typeText, but returns self for chaining calls
    * - Remark: We can't use typeText as it's a native call
    */
   @discardableResult
   public func typeString(_ text: String) -> XCUIElement {
      self.typeText(text)
      return self
   }
   /**
    * Same as adjust, but returns self for chaining calls
    * - Remark: We can't use adjust as it's a native call
    */
   @discardableResult
   public func slide(_ scalar: CGFloat) -> XCUIElement {
      self.adjust(toNormalizedSliderPosition: scalar)
      return self
   }
}
/**
 * Scrolling
 */
extension XCUIElement {
   /**
    * Scrolling
    */
   @discardableResult
   public func scrollTo(dir: ElementModifier.Direction, searchCondition: ElementParser.MatchCondition) -> XCUIElement {
      ElementModifier.scrollTo(element: self, dir: dir, searchCondition: searchCondition)
      return self
   }
   /**
    * Scrolling (beta)
    */
   @discardableResult
   public func scrollToElement(element: XCUIElement) -> XCUIElement {
      ElementModifier.scrollToElement(parent: self, element: element)
      return self
   }
}
/**
 * Tapping
 */
extension XCUIElement {
   /**
    * Helps to tap things that doesn't work with regular .tap() calls. as .tap() calls must be on .isHittable items
    */
   @discardableResult
   public func forceTapElement() -> XCUIElement {
      if self.isHittable {
         self.tap()
      } else {
         let coordinate: XCUICoordinate = self.coordinate(withNormalizedOffset: .init(dx: 0.0, dy: 0.0))
         coordinate.tap()
      }
      return self
   }
   /**
    * Adds convenient way to tap and then wait for a duration (seconds)
    * - Abstract: It's more natural to wait a bit after a tap
    * ## Examples:
    * app.buttons.firstMatch.tap(waitAfter: 0.2)
    */
   @discardableResult
   public func tap(waitAfter sec: Double) -> XCUIElement {
      self.tap()
      return self.wait(after: sec)
   }
   /**
    * Wait for existence then tap
    * ## Examples:
    * app.buttons.firstMatch.tap(waitForExistence: 0.2)
    * - Remark: waitForExistence is a natice call
    */
   @discardableResult
   public func tap(waitForExistence sec: Double) -> XCUIElement? {
      guard self.waitForExistence(timeout: sec) else { return nil }
      self.tap()
      return self
   }
   /**
    * Wait for existence, then tap, then sleep
    * ## Examples:
    * app.buttons.firstMatch.tap(waitForExistence: 0.2, waitAfter: 2.0)
    */
   @discardableResult
   public func tap(waitForExistence secs: Double, waitAfter sleepSecs: Double) -> XCUIElement? {
      guard self.waitForExistence(timeout: secs) else { return nil }
      self.tap()
      return self.wait(after: sleepSecs)
   }
}
// Other
extension XCUIElement {
   /**
    * A convenient way to add some time after a call
    */
   @discardableResult
   public func wait(after sleepSecs: Double) -> XCUIElement {
      sleep(sec: sleepSecs)
      return self
   }
}
