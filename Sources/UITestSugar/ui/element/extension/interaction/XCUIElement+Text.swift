#if canImport(XCTest)
import Foundation
import XCTest
/**
 * Text
 */
extension XCUIElement {
   /**
    * Types the given `text` into the receiver and returns the receiver for chaining calls.
    * This method is equivalent to `typeText`, but returns the receiver instead of `Void`.
    * - Note: Same as typeText, but returns self for chaining calls
    * - Remark: We can't use `typeText` as it's a native call
    * - Parameter text: The text to type into the receiver.
    * - Returns: The receiver, after typing the given `text`.
    */
   @discardableResult public func typeString(_ text: String) -> XCUIElement {
      self.typeText(text) // Type the specified text into the element
      return self// Return the modified element
   }
   /**
    * Clears the given search field and types the provided text.
    * - Parameter text: The text to be typed in the search field.
    * - Returns: The `XCUIElement` representing the search field.
    * - Warning: The returned value is unused, but the function has side effects.
    */
   @discardableResult public func clearSearchFieldAndType(text: String) -> XCUIElement {
      ElementModifier.clearSearchFieldAndType(
         searchField: self, // The search field to clear and type into
         text: text // The text to type into the search field
      ) // Clear the search field and type the specified text
      return self // Return the modified element
   }
   /**
    * Removes any current text in the field before typing in the new value.
    * If the element's value is not a string, the function fails with an error message.
    * - Note: Solution found here: https://stackoverflow.com/a/59288611/5389500
    * - Note: Interesting solution: https://stackoverflow.com/a/73847504/5389500 (The link is a Stack Overflow answer that provides a Swift code snippet for a function that clears the text of a UI element and enters new text into it. The function is part of an extension to the XCUIElement class, which is used for UI testing in Xcode. The answer also includes improved comments for the code snippet)
    * On iOS, the function double-taps the element to select all text before deleting it.
    * On macOS, the function triple-taps the element to select all text before deleting it.
    * After deleting the old text, the function types in the new text.
    * - Parameter text: The text to enter into the field.
    * ## Examples:
    * app.textFields["Email"].clearAndEnterText("newemail@domain.example")
    */
   public func clearAndEnterText(text: String) {
      // Check if the element's value is a string
      guard let stringValue = self.value as? String else {
         XCTFail("⚠️️ Tried to clear and enter text into a non string value")
         return
      }
      // Double-tap the element on iOS, triple-tap on macOS to select all text before deleting it
      #if os(iOS)
      self.tap(
         withNumberOfTaps: 2, // The number of taps to perform
         numberOfTouches: 1 // The number of fingers to use for the tap
      )
      #elseif os(macOS)
      self.doubleTap() // ⚠️️ We need 3 taps to select all, 2 taps sometimes fail to select all if there are special characters etc
      #endif
      // Delete the old text by typing the delete key repeatedly
      let deleteString = String(
         repeating: XCUIKeyboardKey.delete.rawValue, // The string to repeat
         count: stringValue.count // The number of times to repeat the string
      )
      self.typeText(deleteString)
      // Type in the new text
      self.typeText(text)
   }
}
/**
 * New
 */
extension XCUIElement {
   /**
    * Clear and enter text into a UI element
    * - Note: This method clears the existing text in the element and enters the new text.
    * - Note: ref: https://stackoverflow.com/a/73847504/5389500 (The link provided is a reference to a Stack Overflow answer that provides a solution for selecting all text in a UITextField or UITextView on iOS. The solution involves using the selectAll(_:) method of the UITextInput protocol to select all the text in the field or view, and then using the copy(_:) method of the UIPasteboard class to copy the selected text to the pasteboard. This allows the selected text to be copied or replaced with new text. The code in the link is similar to the code in the previous message, but it's written in Swift and uses the UITextField and UITextView classes instead of the XCUIElement class.)
    * - Parameter text: The text to enter into the element.
    */
   public func clearAndWriteText(text: String) {
      self.clear() // Clear the existing text in the element.
      self.typeText(text) // Enter the new text into the element.
      // Note: You can add "\n" at the end of the text to submit the input.
   }
   /**
    * Removes any current text in the field before typing in the new value and submitting
    * Based on: https://stackoverflow.com/a/32894080 (The link provided is a reference to a Stack Overflow answer that provides a solution for selecting all text in a NSTextField or NSTextView on macOS. The solution involves using the selectAll(_:) method of the NSText class to select all the text in the field or view, and then using the writeSelection(to:) method to write the selected text to the pasteboard. This allows the selected text to be copied or replaced with new text. The code in the link is similar to the code in the previous message, but it's written in Objective-C and uses the NSTextField and NSTextView classes instead of the XCUIElement class.)
    */
   public func clear() {
      // Check if the current value is a string
      if self.value as? String == nil {
         // If not, fail the test and return
         XCTFail("Tried to clear and enter text into a non string value")
         return
      }
      // Repeatedly delete text as long as there is something in the text field.
      // This is required to clear text that does not fit in to the textfield and is partially hidden initially.
      // It's important to check for the placeholder value, otherwise it gets into an infinite loop.
      while let stringValue = self.value as? String, !stringValue.isEmpty, stringValue != self.placeholderValue {
         // Move the cursor to the end of the text field
         let lowerRightCorner = self.coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.9))
         lowerRightCorner.tap()
         // Delete the current text by typing the delete key repeatedly
         let delete = String(
            repeating: XCUIKeyboardKey.delete.rawValue, // The string to repeat
            count: stringValue.count // The number of times to repeat the string
         )
         // Swift.print("delete.count:  \(delete.count)")
         self.typeText(delete)
      }
   }
}
#if os(macOS)
extension XCUIElement {
   /**
    * Selects all text in the element and types the given text.
    * Only works for macOS.
    * - Parameter text: The text to type.
    */
   public func selectAllAndWrite(text: String) {
      self.tap(waitForExistence: 5, waitAfter: 0.2) // Tap the element to make sure it's focused.
      self.typeKey("a", modifierFlags: .command) // Select all text in the element.
      self.typeText(text) // Type the given text.
   }
}
#endif // ⚠️️ end if for macos
#endif // ⚠️️ end if for xctest
// app.typeText("New text you want to enter")
// // or use app.keys["delete"].tap() if you have keyboard enabled
//
// _ = stringValue
// self.tap() // it taps in the center
// while ElementModifier.getText(element: self).count != 0 { // Keep removing characters until text is empty, or removing them is not allowed.
//    let stringVal = ElementModifier.getText(element: self)
//    // You can create "delete string" in more functional fashion with: let deleteString = stringValue.characters.map { _ in "\u{8}" }.joinWithSeparator("")
//    let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringVal.count)
//    self.typeText(deleteString)
//    let newStringVal = ElementModifier.getText(element: self)
//    if !newStringVal.isEmpty { self.doubleTap(); } // Ensures that if text is longer than center, that center is reset sort of
// }
// self.typeText(text)
