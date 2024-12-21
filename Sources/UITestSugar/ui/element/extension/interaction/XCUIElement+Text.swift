#if canImport(XCTest)
import Foundation
import XCTest
/**
 * Text
 */
extension XCUIElement {
   /**
    * Types the specified `text` into the current element and returns the element itself to facilitate method chaining.
    * - Description: This method allows for typing text into an element, similar to the native `typeText` method. However, unlike `typeText` which does not return any value, this method returns the element itself, enabling the chaining of further method calls on the same element.
    * - Note: This is a custom implementation that wraps the native `typeText` call to include chaining functionality.
    * - Parameter text: The text to be typed into the element.
    * - Returns: The current element, allowing for additional operations to be performed in a chained manner.
    */
   @discardableResult public func typeString(_ text: String) -> XCUIElement {
      self.typeText(text) // Type the specified text into the element
      return self // Return the modified element
   }
   /**
    * Clears the given search field and types the provided text.
    * This method is useful for resetting a search field to a known state before entering new text, ensuring that previous entries do not affect the current operation.
    * - Parameter text: The text to be typed in the search field.
    * - Returns: The `XCUIElement` representing the search field.
    * - Warning: The returned value is unused, but the function has side effects such as altering the state of the UI.
    */
   @discardableResult public func clearSearchFieldAndType(text: String) -> XCUIElement {
      ElementModifier.clearSearchFieldAndType(
         searchField: self, // The search field to clear and type into
         text: text // The text to type into the search field
      ) // Clear the search field and type the specified text
      return self // Return the modified element
   }
   /**
    * Clears any existing text from the field and types in a new specified value.
    * This method first checks if the current value of the element is a string. If not, it logs an error and exits. For iOS, it double-taps to select all text, and for macOS, it triple-taps. However, due to issues with SwiftUI text fields on macOS, a vector-based tap followed by a 'Select All' command is used instead.
    * After clearing the text, the new text is typed into the field.
    * - Parameter text: The text to be entered into the field after clearing it.
    * - Note: On iOS, the function double-taps the element to select all text before deleting it. // - Fixme: ⚠️️ this seems wrong
    * - Note: On macOS, the function triple-taps the element to select all text before deleting it. // - Fixme: ⚠️️ this seems wrong
    * - Note: Solution found here: https://stackoverflow.com/a/59288611/5389500
    * - Note: Interesting solution: https://stackoverflow.com/a/73847504/5389500 (The link is a Stack Overflow answer that provides a Swift code snippet for a function that clears the text of a UI element and enters new text into it. The function is part of an extension to the XCUIElement class, which is used for UI testing in Xcode. The answer also includes improved comments for the code snippet)
    * - Fixme: ⚠️️ this is buggy for macOS with swiftui textfield, use vector tap + select all
    * - Example:
    *   ```
    *   app.textFields["Email"].clearAndEnterText("newemail@domain.example")
    *   ```
    */
   public func clearAndEnterText(text: String) {
      // Check if the element's value is a string by attempting to cast the value to a String type.
      // This ensures that the element can hold text, which is necessary for operations like clearing and entering new text.
      // If the cast fails, it indicates that the element's value is not a string, and an error is logged.
      guard let stringValue: String = self.value as? String else {
         XCTFail("⚠️️ Tried to clear and enter text into a non string value")
         return
      }
      // Double-tap the element on iOS, triple-tap on macOS to select all text before deleting it
      #if os(iOS)
      self.tap(
         withNumberOfTaps: 3, // The number of taps to perform (was 2, but fails at selecting all text)
         numberOfTouches: 1 // The number of fingers to use for the tap
      )
      #elseif os(macOS)
      self.doubleTap() // ⚠️️ We need 3 taps to select all, 2 taps sometimes fail to select all if there are special characters etc
      #endif
      deleteAllAndEnterText(stringValue: stringValue, text: text)
   }
   /**
    * - Note requires textfield is in focus and all text is selected
    */
   public func deleteAllAndEnterText(stringValue: String, text: String) {
      // Delete the old text by typing the delete key repeatedly
      let deleteString: String = .init(
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
    * Clears the existing text from a UI element and inputs new text.
    * This method is designed to first clear any text currently in the UI element and then input the specified text. It is useful for text fields where the existing content needs to be replaced entirely.
    * - Note: This method utilizes the selectAll(_:) method from the UITextInput protocol to select all text in a UITextField or UITextView on iOS, followed by using the copy(_:) method from the UIPasteboard class to copy the selected text. This ensures that the existing text can be replaced with new content. For more details, see the solution at: https://stackoverflow.com/a/73847504/5389500
    * - Parameter text: The new text to be entered into the UI element.
    */
   public func clearAndWriteText(text: String) {
      self.clear() // Clear the existing text in the element.
      self.typeText(text) // Enter the new text into the element.
      // - Note: You can add "\n" at the end of the text to submit the input.
   }
   /**
    * Clears any existing text from the field and types in a new value, preparing the field for new input.
    * - Description: This method is designed to remove any text currently present in the field by selecting all text and then deleting it. After clearing the field, the new text is typed in, effectively replacing the old content. This operation is crucial for fields that require fresh data input without appending to existing content.
    * - Note: The implementation is inspired by a solution on Stack Overflow (https://stackoverflow.com/a/32894080) which discusses techniques for selecting and replacing text in NSTextField or NSTextView on macOS using Objective-C. This method adapts those principles for XCUIElement in Swift, ensuring compatibility and functionality across UI tests.
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
      while let stringValue: String = self.value as? String, !stringValue.isEmpty, stringValue != self.placeholderValue {
         // Move the cursor to the end of the text field
         let lowerRightCorner: XCUICoordinate = self.coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.9))
         lowerRightCorner.tap()
         // Delete the current text by typing the delete key repeatedly
         let delete: String = .init(
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
    * This method is specifically designed for macOS environments. It selects all existing text within the element and replaces it with the specified new text. This is particularly useful for text fields or text areas where the entire content needs to be replaced.
    * - Parameters:
    *   - text: The text to be typed into the element after selecting all existing text.
    *   - tapBegining: If true, taps at the beginning of the element to ensure it is focused before selecting all text. This is a workaround for a known issue where text fields in certain UI contexts may not receive focus correctly.
    */
   public func selectAllAndWrite(text: String, tapBegining: Bool = false) {
      if tapBegining { // ⚠️️ hack to set focus, bug in TextField in List for macOS
         let centerLeftVector: CGVector = .init(dx: 0.1, dy: 0.5) // Center left
         let coordinate: XCUICoordinate = self.coordinate(withNormalizedOffset: centerLeftVector) // iOS / macOS
         coordinate.tap()
      } else {
         self.tap(waitForExistence: 5, waitAfter: 0.2) // Tap the element to make sure it's focused.
      }
      self.typeKey("a", modifierFlags: .command) // Select all text in the element.
      self.typeText(text) // Type the given text.
   }
}
#endif // ⚠️️ end if for macos
#endif // ⚠️️ end if for xctest
