#if canImport(XCTest)
import Foundation
import XCTest

public class ElementAsserter {
   /**
    * Asserts if an item exists in the UI hierarchy and if it's visible with the window frame.
    * - Parameters:
    *   - element: The element to assert if it exists and is visible.
    *   - timeout: The duration to wait before failing and returning false.
    * - Remark: This function waits for the specified element to exist in the UI hierarchy and checks if it's visible with the window frame. If the element exists and is visible, this function returns true. If the element doesn't exist or isn't visible, this function returns false.
    * - Remark: This function is useful for asserting the existence and visibility of UI elements in UI testing. You can use it to ensure that the UI elements in your app are present and visible to the user.
    * ## Example:
    * let app = XCUIApplication()
    * let button = app.buttons["myButton"]
    * XCTAssertTrue(ElementAsserter.existsAndVisible(element: button, timeout: 5))
    */
   public static func existsAndVisible(element: XCUIElement, timeout: Double) -> Bool {
      // Wait for the specified element to exist in the UI hierarchy
      let exists = element.waitForExistence(timeout: timeout)
      // Check if the element is visible with the window frame
      let visible = isVisibleInWindow(element: element)
      // Return true if the element exists and is visible, false otherwise
      return exists && visible
   }
   /**
    * Asserts if an element is visible on screen.
    * - Parameter element: The element to assert if it's visible in the window.
    * - Remark: This function checks if the specified element exists and has a non-empty frame. If the element exists and has a non-empty frame, this function checks if the element's frame is contained within the frame of the main window. If the element's frame is contained within the frame of the main window, this function returns true. If the element doesn't exist, has an empty frame, or its frame isn't contained within the frame of the main window, this function returns false.
    * - Remark: This function is useful for asserting the visibility of UI elements in UI testing. You can use it to ensure that the UI elements in your app are visible to the user.
    * ## Example:
    * let app = XCUIApplication()
    * let button = app.buttons["myButton"]
    * XCTAssertTrue(ElementAsserter.isVisibleInWindow(element: button))
    */
   public static func isVisibleInWindow(element: XCUIElement) -> Bool {
      // Check if the element exists and has a non-empty frame
      guard element.exists && !element.frame.isEmpty else { return false }
      
      // Check if the element's frame is contained within the frame of the main window
      return XCUIApplication().windows.element(boundBy: 0).frame.contains(element.frame)
   }
   /**
    * Checks if an element exists and is hittable.
    * - Parameter element: The element to check if it exists and is hittable.
    * - Remark: This function checks if the specified element exists and is hittable. If the element exists and is hittable, this function returns true. If the element doesn't exist or isn't hittable, this function returns false.
    * - Remark: This function is useful for checking the existence and hittability of UI elements in UI testing. You can use it to ensure that the UI elements in your app are present and can be interacted with by the user.
    * ## Example:
    * let app = XCUIApplication()
    * let button = app.buttons["myButton"]
    * XCTAssertTrue(ElementAsserter.existsAndIsHittable(element: button))
    */
   public static func existsAndIsHittable(element: XCUIElement) -> Bool {
      // Check if the element exists and is hittable
      return element.exists && element.isHittable
   }
   /**
    * Asserts if an element exists.
    * - Remark: This function checks if the specified element exists. If the element exists, this function returns true. If the element doesn't exist, this function returns false.
    * - Remark: This function is useful for checking the existence of UI elements in UI testing. You can use it to ensure that the UI elements in your app are present and can be interacted with by the user.
    * ## Example:
    * let app = XCUIApplication()
    * let button = app.buttons["myButton"]
    * XCTAssertTrue(ElementAsserter.exists(element: button))
    */
   public static func exists(element: XCUIElement) -> Bool {
      // Check if the element exists
      return element.exists
   }
   /**
    * Asserts if an element exists (with timeout).
    * - Description: This method can be used when you expect an element to appear on the screen but need to wait for something like an animation, a video ad, or simply because of load time. This property was introduced in Xcode 9, though we have used API similar to this to test features that involve waiting through video ads.
    * - Remark: This method is synchronous. It waits for the specified element to exist in the UI hierarchy and returns true if the element exists within the specified timeout. If the element doesn't exist within the specified timeout, this method returns false.
    * - Remark: ⚠️️ Prefer the native `waitForExistence` if possible.
    * - Parameters:
    *   - element: The element to check if it exists.
    *   - timeout: The duration to wait before failing and returning false.
    * - Returns: A boolean value that indicates whether the element exists within the specified timeout.
    * ## Examples:
    * let app = XCUIApplication()
    * let button = app.buttons["myButton"]
    * XCTAssertTrue(ElementAsserter.exists(element: button, timeout: 5))
    */
   public static func exists(element: XCUIElement, timeout: Double) -> Bool {
      // Wait for the specified element to exist in the UI hierarchy
      element.waitForExistence(timeout: timeout)
   }
   /**
    * Asserts if all elements in an array exists
    * - Parameter elements: the array of elements to check if exists
    */
   public static func allExists(elements: [XCUIElement]) -> Bool {
      // Check if any element in the array does not exist
      elements.contains { !$0.exists }
   }
   /**
    * Asserts if an element has a specific text.
    * - Remark: This function checks if the specified element has the specified text. If the element has the specified text, this function returns true. If the element doesn't have the specified text, this function returns false.
    * - Remark: This function is useful for asserting the text of UI elements in UI testing. You can use it to ensure that the UI elements in your app have the correct text and are accessible to users.
    * - Remark: ⚠️️ This function doesn't always work with `macOS`.
    * ## Example:
    * let app = XCUIApplication()
    * let alert = app.alerts.element
    * XCTAssertTrue(ElementAsserter.hasText(element: alert, text: "Please enter a valid email address"))
    */
   public static func hasText(element: XCUIElement, text: String) -> Bool {
      // Check if the specified element has the specified text
      return element.staticTexts[text].exists
   }
   /**
    * Checks if an element has a label.
    * - Parameters:
    *   - element: The element to check if it has a label.
    *   - text: The label text to check for.
    *   - type: The element type to check for.
    * - Remark: This function checks if the specified element has a label with the specified text and type. If the element has a label with the specified text and type, this function returns true. If the element doesn't have a label with the specified text and type, this function returns false.
    * - Remark: This function is useful for checking the label of UI elements in UI testing. You can use it to ensure that the UI elements in your app have the correct labels and are accessible to users with visual impairments.
    * ## Example:
    * let app = XCUIApplication()
    * let button = app.buttons["myButton"]
    * XCTAssertTrue(ElementAsserter.hasLabel(element: button, text: "My Button", type: .button))
    */
   public static func hasLabel(element: XCUIElement, text: String, type: XCUIElementType) -> Bool {
      // Check if the specified element has a label with the specified text and type
      return element.firstDescendant(label: text, type: type).exists
   }
}
#endif
// element.self.descendants(matching: type).element.label == text
// element.staticTexts[text].exists
