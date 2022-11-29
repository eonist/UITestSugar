#if canImport(XCTest)
import Foundation
import XCTest
/**
 * Text
 * - Fixme: ⚠️️ rename to XCUIElement+Text?
 */
extension XCUIElement {
   /**
    * Same as typeText, but returns self for chaining calls
    * - Remark: We can't use typeText as it's a native call
    * - Parameter text: - Fixme: ⚠️️ doc
    */
   @discardableResult public func typeString(_ text: String) -> XCUIElement {
      self.typeText(text)
      return self
   }
   /**
    * Clear SearchField and type
    * - Parameter text: - Fixme: ⚠️️ doc
    */
   @discardableResult public func clearSearchFieldAndType(text: String) -> XCUIElement {
      ElementModifier.clearSearchFieldAndType(searchField: self, text: text)
      return self
   }
   /**
    * New ⚠️️
    * - Description: Removes any current text in the field before typing in the new value
    * - Note: Solution found here: https://stackoverflow.com/a/59288611/5389500
    * - Note: Interesting solution: https://stackoverflow.com/a/73847504/5389500
    * - Parameter text: the text to enter into the field
    * ## Examples:
    * app.textFields["Email"].clearAndEnterText("newemail@domain.example")
    */
   public func clearAndEnterText(text: String) {
      guard let stringValue = self.value as? String else {
         XCTFail("⚠️️ Tried to clear and enter text into a non string value")
         return
      }
      #if os(iOS)
      self.tap(withNumberOfTaps: 2, numberOfTouches: 1)
      #elseif os(macOS)
      self.doubleTap() // ⚠️️ We need 3 taps to select all, 2 taps sometimes fail to select all if there are special characters etc
      #endif
      let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
//      Swift.print("deleteString.count:  \(deleteString.count)")
      self.typeText(deleteString)
//      sleep(sec: 1)
      self.typeText(text)
   }
}
/**
 * New
 */
extension XCUIElement {
   /**
    * Clear and enter text
    * - Note: ref: https://stackoverflow.com/a/73847504/5389500
    */
   public func clearAndWriteText(text: String) {
      self.clear()
      self.typeText(text) // "\()\n" // new line at end submits
   }
   /**
    * Removes any current text in the field before typing in the new value and submitting
    * Based on: https://stackoverflow.com/a/32894080
    */
   public func clear() {
      if self.value as? String == nil {
         XCTFail("Tried to clear and enter text into a non string value")
         return
      }
      // Repeatedly delete text as long as there is something in the text field.
      // This is required to clear text that does not fit in to the textfield and is partially hidden initally.
      // Important to check for placeholder value, otherwise it gets into an infinite loop.
      while let stringValue = self.value as? String, !stringValue.isEmpty, stringValue != self.placeholderValue {
         // Move the cursor to the end of the text field
         let lowerRightCorner = self.coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.9))
         lowerRightCorner.tap()
         let delete = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
         Swift.print("delete.count:  \(delete.count)")
         self.typeText(delete)
      }
   }
}
extension XCUIElement {
   /**
    * works for macOS
    */
   public func selectAllAndWrite(text: String) {
      self.tap(waitForExistence: 5, waitAfter: 0.2)
      self.typeKey("a", modifierFlags: .command) // select all (clearAndType doesnt work well on exotic characters)
      self.typeText(text)
   }
}
#endif
//
//      app.typeText("New text you want to enter")
//      // or use app.keys["delete"].tap() if you have keyboard enabled
//
//      _ = stringValue
//      self.tap() // it taps in the center
//      while ElementModifier.getText(element: self).count != 0 { // Keep removing characters until text is empty, or removing them is not allowed.
//         let stringVal = ElementModifier.getText(element: self)
//         // You can create "delete string" in more functional fashion with: let deleteString = stringValue.characters.map { _ in "\u{8}" }.joinWithSeparator("")
//         let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringVal.count)
//         self.typeText(deleteString)
//         let newStringVal = ElementModifier.getText(element: self)
//         if !newStringVal.isEmpty { self.doubleTap(); } // Ensures that if text is longer than center, that center is reset sort of
//      }
//      self.typeText(text)
