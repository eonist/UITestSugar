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
   public func scrollToElement(element: XCUIElement) {
      ElementModifier.scrollToElement(parent: self, element: element)
   }
}
