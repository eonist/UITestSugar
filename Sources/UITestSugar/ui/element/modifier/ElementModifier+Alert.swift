#if canImport(XCTest)
import Foundation
import XCTest
/**
 * Alert
 */
extension ElementModifier {
   /**
    * Return a button in an alert
    * - Important: ⚠️️ You can setup handlers for random alert screens: `addUIInterruptionMonitor(withDescription: "Location Dialog") { (alert) -> Bool in alert.buttons["Allow"].tap() return true }`
    * - Parameters:
    *   - app: A reference to the app
    *   - alertTitle: The id of the alert
    *   - alertButtonTitle: The id of the button to take action on
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
