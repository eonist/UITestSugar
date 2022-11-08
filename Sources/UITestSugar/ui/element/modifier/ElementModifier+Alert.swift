#if os(iOS)
import Foundation
import XCTest
/**
 * Alert
 */
extension ElementModifier {
   /**
    * Return a button in an alert
    * - Important: ⚠️️ You can setup handlers for random alert screens: addUIInterruptionMonitor(withDescription: "Location Dialog") { (alert) -> Bool in alert.buttons["Allow"].tap() return true }
    * - Parameters:
    *   - app: A reference to the app
    *   - alertTitle: The id of the alert
    *   - alertButtonTitle: The id of the button to take action on
    * ## Examples:
    * ElementModifier.alert(app: app, alertTitle: "Warning", alertButtonTitle: "OK")
    */
   public static func alert(app: XCUIApplication, alertTitle: String, alertButtonTitle: String) -> XCUIElement {
      app.alerts[alertTitle].buttons[alertButtonTitle]
   }
}
#endif
