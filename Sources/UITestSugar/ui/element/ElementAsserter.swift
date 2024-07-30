#if canImport(XCTest)
import Foundation
import XCTest

public class ElementAsserter {
   /**
    * Asserts if an item exists in the UI hierarchy and if it's visible within the window frame.
    * - Description: This method verifies the presence and visibility of a UI element within the application's main window. It waits up to a specified timeout for the element to appear and checks if it is visible within the window's frame.
    * - Parameters:
    *   - element: The element to assert if it exists and is visible.
    *   - timeout: The duration to wait before concluding the element does not exist or is not visible.
    * - Remark: This function is essential for validating that UI elements are not only present but also visible to the user, which is crucial for interactive UI tests.
    * - Example:
    *   let app = XCUIApplication()
    *   let button = app.buttons["myButton"]
    *   XCTAssertTrue(ElementAsserter.existsAndVisible(element: button, timeout: 5))
    */
   public static func existsAndVisible(element: XCUIElement, timeout: Double) -> Bool {
      // Wait for the specified element to exist in the UI hierarchy
      let exists: Bool = element.waitForExistence(timeout: timeout)
      // Check if the element is visible with the window frame
      let visible: Bool = isVisibleInWindow(element: element)
      // Return true if the element exists and is visible, false otherwise
      return exists && visible
   }
   /**
    * Validates if a UI element is visible within the application's main window.
    * - Parameter element: The UI element to validate for visibility within the window.
    * - Description: This function first checks if the provided element exists and has a non-empty frame. If these conditions are met, it then verifies if the element's frame is within the bounds of the main window's frame. If the element's frame is within the main window's frame, the function returns true, indicating that the element is visible on the screen. If the element does not exist, has an empty frame, or its frame is not within the main window's frame, the function returns false, indicating that the element is not visible on the screen.
    * - Remark: This function is a crucial tool for UI testing, as it allows you to assert the visibility of UI elements within your application. By using this function, you can ensure that the UI elements in your app are not only present but also visible to the user.
    * ## Example:
    * let app = XCUIApplication()
    * let button = app.buttons["myButton"]
    * XCTAssertTrue(ElementAsserter.isVisibleInWindow(element: button))
    */
   public static func isVisibleInWindow(element: XCUIElement) -> Bool {
      // Check if the element exists and has a non-empty frame
      guard element.exists && !element.frame.isEmpty else { 
         return false 
      }
      // Check if the element's frame is contained within the frame of the main window
      return XCUIApplication().windows.element(boundBy: 0).frame.contains(element.frame)
   }
   /**
    * Verifies that a UI element is present in the application and can be interacted with.
    * - Parameter element: The UI element to verify for existence and hittability.
    * - Description: This method checks whether the specified UI element is present in the application's UI hierarchy and is hittable, meaning it can be interacted with (e.g., clicked or tapped). It returns true if the element both exists and is hittable, and false if either condition is not met.
    * - Remark: This method is crucial for ensuring that UI elements are not only present but also functional and accessible for user interactions during UI testing.
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
    * - Description: This method checks the existence of a specified UI element within the application's UI hierarchy. It returns true if the element is found, otherwise it returns false.
    * - Remark: This function is essential for verifying the presence of UI elements during UI testing. It helps ensure that elements are available for interaction, which is crucial for automated UI tests.
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
    * Asserts if an element exists within a specified timeout period.
    * - Description: This method is designed to verify the existence of a UI element within a given timeout, accommodating scenarios such as animations or loading delays. Introduced in Xcode 9, this API facilitates testing features that require waiting, such as video ads. The method synchronously waits for the element to appear in the UI hierarchy and returns a boolean indicating its existence within the timeout period.
    * - Remark: This method is synchronous, blocking execution until the timeout expires or the element is found.
    * - Remark: ⚠️️ It is recommended to use the native `waitForExistence` method when possible for better performance and reliability.
    * - Parameters:
    *   - element: The UI element to check for existence.
    *   - timeout: The maximum time (in seconds) to wait for the element to appear before returning false.
    * - Returns: `true` if the element exists within the timeout period; otherwise, `false`.
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
    * Asserts if all elements in an array exist.
    * - Description: This method checks each element in the provided array to determine if every element exists within the application's UI hierarchy. It returns true if all elements exist, otherwise it returns false.
    * - Parameter elements: The array of UI elements to verify for existence.
    * - Returns: `true` if all elements in the array exist; otherwise, `false`.
    */
   public static func allExists(elements: [XCUIElement]) -> Bool {
      // Check if any element in the array does not exist
      elements.contains { !$0.exists }
   }
   /**
    * Asserts if an element has a specific text.
    * - Description: This method verifies whether the specified UI element contains the given text. It is crucial for validating the textual content of UI elements during automated UI testing, ensuring that they display the expected text to the user.
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
    * Verifies if an element has a specific label with a given text and type.
    * - Description: This method checks whether a UI element, such as a button or label, has a specific text as its label. It is essential for ensuring that UI elements are correctly labeled, enhancing accessibility and usability in applications.
    * - Parameters:
    *   - element: The element to verify for the presence of a label.
    *   - text: The label text to check for.
    *   - type: The type of the element to be checked.
    * - Remark: This function returns true if the element has a label matching the specified text and type, otherwise it returns false.
    * - Remark: This is particularly useful in UI testing for validating that elements are properly labeled for accessibility purposes, such as for users with visual impairments.
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