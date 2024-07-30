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
    * Clears any existing text in a text field and types a new value.
    * This method first clears any text present in the specified text field and then types the provided text into it.
    * - Parameters:
    *   - element: The XCUIElement representing the text field to modify.
    *   - text: The new text to be entered into the text field.
    * - Remark: Utilizes the `clearAndEnterText(text:)` method of `XCUIElement` to clear existing text and input new text.
    * - Important: ⚠️️ This method may not effectively clear very long texts. For fields with extensive existing text, consider alternative clearing methods.
    * - Important: ⚠️️ For password fields, refer to: https://stackoverflow.com/questions/32184837/ui-testing-failure-neither-element-nor-any-descendant-has-keyboard-focus-on-se
    * - Fixme: ⚠️️ Consider implementing error handling for this method.
    * ## Examples:
    * let app = XCUIApplication()
    * let textField = app.textFields.element
    * ElementModifier.clearAndTypeText(element: textField, text: "Hello, world!")
    */
   public static func clearAndTypeText(element: XCUIElement, text: String) {
      // Note: This method may not function correctly with secure text fields. Refer to previous versions for secure text handling.
      // Clear any existing text and type the new text
      element.clearAndEnterText(text: text)
   }
   /**
    * Clears any existing text from a search field and inputs new text.
    * This method ensures that the search field is first activated and cleared of any previous entries before new text is typed into it.
    * - Parameters:
    *   - searchField: The XCUIElement representing the search field to be modified.
    *   - text: The new text to be entered into the search field.
    * - Remark: This function employs the `tap(waitForExistence:waitAfter:)` method to focus the search field and the `typeText(_:)` method to input text. It ensures the search field's clear button is tapped to remove old text.
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
    * Retrieves the text content of an element.
    * This method extracts the text content from the `value` property of an `XCUIElement`, typically used for elements like text fields and labels.
    * - Parameters:
    *   - element: The XCUIElement from which to retrieve the text.
    * - Remark: This function directly accesses the `value` property of `XCUIElement` to obtain the text as a string.
    * - Important: ⚠️️ This function will return an error if the `value` property does not contain a `String`. Use alternative methods if this issue arises.
    * - Fixme: ⚠️️ Consider refactoring this function into a more appropriate class, such as a parser, to improve modularity.
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
