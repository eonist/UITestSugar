#if canImport(XCTest)
import Foundation
import XCTest
/**
 * Alert
 */
extension ElementModifier {
   /**
    * Retrieves a button from a specified alert.
    * - Description: This method locates an alert by its title and then retrieves a button within that alert by its title. It is useful for interacting with buttons on alert dialogs during UI tests.
    * - Important: ⚠️️ You can setup handlers for random alert screens: `addUIInterruptionMonitor(withDescription: "Location Dialog") { (alert) -> Bool in alert.buttons["Allow"].tap() return true }`
    * - Parameters:
    *   - app: A reference to the app
    *   - alertTitle: The title of the alert
    *   - alertButtonTitle: The title of the button to interact with
    * ## Examples:
    * ElementModifier.alert(app: app, alertTitle: "Warning", alertButtonTitle: "OK")
    */
   public static func alert(app: XCUIApplication, alertTitle: String, alertButtonTitle: String) -> XCUIElement {
      // Get the `alerts` query for the current application
      let alert: XCUIElement = app.alerts[alertTitle] // Get the alert element with the specified title
      // Get the button element with the specified title in the alert with the specified title
      let button: XCUIElement = alert.buttons[alertButtonTitle] // Get the button element with the specified title from the alert
      return button // Return the button element
   }
}
#endif
