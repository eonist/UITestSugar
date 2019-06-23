import Foundation
import XCTest

public class ElementAsserter {
   /**
    * Asserts if an element is visible on screen
    * Fixme: ⚠️️ write example
    */
   public static func visible(element: XCUIElement) -> Bool {
      guard element.exists && !element.frame.isEmpty else { return false }
      return XCUIApplication().windows.element(boundBy: 0).frame.contains(element.frame)
   }
   /**
    * Asserts if an element exists
    * @Example:
    * XCTAssertTrue(ElementAsserter(element: app.buttons[“Sign up”]).exists) // ✅
    */
   public static func exists(element: XCUIElement) -> Bool {
      return element.exists
   }
   /**
    * Asserts if all elements in an array exists
    */
   public static func allExists(elements: [XCUIElement]) -> Bool {
      return elements.first { !$0.exists } == nil
   }
   /**
    * ## Examples
    * hasText(element: app.alerts.element,"Please enter a valid email address")
    */
   public static func hasText(element: XCUIElement, text: String) -> Bool {
      return element.staticTexts[text].exists
   }
}
