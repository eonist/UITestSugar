#if canImport(XCTest)
import Foundation
import XCTest
/**
 * TextField manipulation
 * - Description: The ElementModifier class provides a set of functions for modifying UI elements in UI testing using Xcode's XCUIElement framework. The class includes functions for scrolling, tapping, and swiping elements, as well as functions for modifying element attributes such as text and value.
 * - Note: Has hacky code to get keyboard focus: https://stackoverflow.com/a/65208481/5389500
 */
public class ElementModifier {
   /**
    * Clears any current text in a text field before typing in the new value.
    * - Parameters:
    *   - element: The element to clear and type text into.
    *   - text: The text to enter into the field.
    * - Remark: This function uses the `clearAndEnterText(text:)` method of `XCUIElement` to clear any current text in the field before typing in the new value.
    * - Important: ⚠️️ This solution has problems with long pre-existing texts. If the text field already contains a long text, this function may not clear the entire text field. Consider using a different solution if you encounter this issue.
    * - Important: ⚠️️ FOR PASSWORD-FIELDS you may need to read this: https://stackoverflow.com/questions/32184837/ui-testing-failure-neither-element-nor-any-descendant-has-keyboard-focus-on-se
    * - Fixme: ⚠️️ Consider making this a try error method.
    * ## Examples:
    * let app = XCUIApplication()
    * let textField = app.textFields.element
    * ElementModifier.clearAndTypeText(element: textField, text: "Hello, world!")
    */
   public static func clearAndTypeText(element: XCUIElement, text: String) {
      // ⚠️️ Might not work with secure text now, see older version of this where it worked etc
      // Clear any current text in the field
      // and enter the new text
      element.clearAndEnterText(text: text)
   }
   /**
    * Clears a search field and types in the new text.
    * - Parameters:
    *   - searchField: The search field to clear and type text into.
    *   - text: The text to enter into the field.
    * - Remark: This function uses the `tap(waitForExistence:waitAfter:)` method of `XCUIElement` to tap the search field and its clear button, and the `typeText(_:)` method of `XCUIElement` to enter the new text into the field.
    * ## Examples:
    * let app = XCUIApplication()
    * let searchField = app.searchFields.firstMatch
    * ElementModifier.clearSearchFieldAndType(searchField: searchField, text: "Hello, world!")
    */
   public static func clearSearchFieldAndType(searchField: XCUIElement, text: String) {
      // Tap the search field to activate it
      searchField.tap(
         waitForExistence: 5, // The maximum amount of time to wait for the element to exist
         waitAfter: 0.2 // The amount of time to wait after tapping the element
      )
      // Tap the clear button of the search field
      searchField.buttons.firstMatch.tap(
         waitForExistence: 5, // The maximum amount of time to wait for the element to exist
         waitAfter: 0.2 // The amount of time to wait after tapping the element
      )
      // Type the new text into the search field
      searchField.typeText(text)
   }
}
/**
 * Alternate clear and type methodology
 */
extension ElementModifier {
   /**
    * Returns `value` as a String.
    * - Parameters:
    *   - element: The element to get text from.
    * - Remark: This function uses the `value` property of `XCUIElement` to get the text of the specified element as a string.
    * - Important: ⚠️️ This function will fail if `value` is not a `String` type. Consider using a different solution if you encounter this issue.
    * - Fixme: ⚠️️ Consider moving this function to a parser.
    * ## Examples:
    * let app = XCUIApplication()
    * let textField = app.textFields.element
    * let text = ElementModifier.getText(element: textField)
    */
   internal static func getText(element: XCUIElement) -> String {
      // Get the text of the element as a string
      guard let text: String = element.value as? String else {
         // If the value is not a string, fail with a precondition
         preconditionFailure("Value: \(String(describing: element.value)) is not a String")
      }
      // Return the text as a string
      return text
   }
}
#endif
//guard let stringValue: String = element.value as? String else {
//   XCTFail("⚠️️ Tried to clear and enter text into a non string value")
//   return
//}
//element.tap(waitForExistence: 5, waitAfter: 0.5) // it taps in the center
//for _ in 0..<stringValue.count { // Fixme: ⚠️️ do stringValue.forEach {_ in } here, test first
//   element.typeText(XCUIKeyboardKey.delete.rawValue) // this takes a while if there is alot of text
//   // - Fixme: ⚠️️ fix this, google etc
//   element.tap() // Ensures that if text is longer than center, that center is reset sort of
//}
////      clearTextField(element: element) // extra
//if stringValue.isEmpty { element.tap() } // ⚠️️ unsure why we tap again?
//element.typeText(text)
