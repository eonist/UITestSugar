import Foundation
import XCTest

public class ElementAsserter {
   /**
    * Asserts if item exists in the UI-hierarchy and if its visible with the window-frame (⚠️️ Beta ⚠️️)
    * - Parameter element: The element to assert if exisit and is visible
    * - Parameter timout: THe duration to wait before failing and returning false
    */
   public static func existsAndVisible(element: XCUIElement, timeout: Double) -> Bool {
      return element.waitForExistence(timeout: timeout) && isVisibleInWindow(element: element)
   }
   /**
    * Asserts if an element is visible on screen (⚠️️ Beta ⚠️️)
    * ## Examples:
    * isVisibleInWindow(element: app) // true / false
    * - Parameter element: The element to assert if is visible in window
    */
   public static func isVisibleInWindow(element: XCUIElement) -> Bool {
      guard element.exists && !element.frame.isEmpty else { return false }
      return XCUIApplication().windows.element(boundBy: 0).frame.contains(element.frame)
   }
   /**
    * Indicates if the element is currently visible on the screen.  (⚠️️ Beta ⚠️️)
    * ## Examples: XCTAssertTrue(app.buttons.element.isVisible) // ✅
    * - Important: ⚠️️ When accessing properties of XCUIElement, XCTest works differently than in a case of actions on elements, there is no waiting for the app to idle and to finish all animations., This can lead to problems and test flakiness as the test will evaluate a query before e.g. view transition has been completed.
    * - Parameter element: Checks if the element exists and isHittable
    */
   func existsAndIsHittable(element: XCUIElement) -> Bool {
     return element.exists && element.isHittable
   }
   /**
    * Asserts if an element exists
    * @Example:
    * XCTAsserstTrue(ElementAsserter.exists(element: app.buttons[“Sign up”])) // ✅
    * - Parameter element: The element to check if exists
    * - Note: Does not wait. Asserts immidiatly. use waitForExistence method to assert with wait
    */
   public static func exists(element: XCUIElement) -> Bool {
      return element.exists
   }
   /**
    * Asserts if an element exists (with timeout)
    * - Abstract: This method can be used when you expect for an element to appear on the screen but needs to wait for something like an animation, or a video ad, or simply because of load time. This property was introduced in XCode 9, though we have used API similar to this to test features that involve waiting through video ads.
    * - Note: This method is syncronouse. So it will wait and then call the next item once its complete
    * ## Examples:
    * ElementAsserter.exists(element: app.buttons[“Sign up”], timeout: 10)
    * - Remark: ⚠️️ Prefer the natice waitForExistance if possible
    * - Parameter element: The element to check if exists
    * - Parameter timeout: the amount of wating until it fails
    */
   public static func exists(element: XCUIElement, timeout: Double) -> Bool {
      return element.waitForExistence(timeout: timeout)
   }
   /**
    * Asserts if all elements in an array exists
    * - Parameter elements: the array of elements to check if exists
    */
   public static func allExists(elements: [XCUIElement]) -> Bool {
      return elements.first { !$0.exists } == nil
   }
   /**
    * ## Examples
    * hasText(element: app.alerts.element,"Please enter a valid email address")
    * - Parameter element: The element to assert if has text
    * - Parameter text: The text to assert if exists
    */
   public static func hasText(element: XCUIElement, text: String) -> Bool {
      return element.staticTexts[text].exists
   }
}
extension ElementAsserter {
   /**
    * - Abstract: Search down a scroll view until it finds a certain element
    * - Note: there is also: firstScrollView.scrollToElement(element: seventhChild)
    * - Parameter app:
    */
   public static func scrollDownUntilFound(element: XCUIElement, id: String, type: XCUIElement.ElementType, timeOut: Double = 10) {
      var exists: Bool = false
      repeat {
         let element: XCUIElement = element.descendants(matching: type).element(matching: type, identifier: id).firstMatch
         exists = ElementAsserter.exists(element: element, timeout: timeOut)
         if exists { element.swipeUp() } // no need to swipeUp if found
      } while !exists
   }
}
