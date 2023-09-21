import Foundation
#if canImport(XCTest)
import XCTest

extension XCUIApplication {
   /**
    * Dismisses a popup.
    * - Remark: This function dismisses a popup by tapping the "Cancel" button. It searches for the "Cancel" button by its accessibility identifier, which should be set to "Cancel".
    * - Remark: This function is useful for dismissing popups in UI testing. You can use it to ensure that the popups in your app are dismissed correctly and that the user can continue interacting with the app.
    * - Remark: ⚠️️ This function might not work in all cases. If the "Cancel" button doesn't exist or has a different accessibility identifier, this function won't work.
    * - Remark: You can also use the following code to dismiss a popup: `XCUIApplication().buttons["Dismiss"].tap()`
    * - Fixme: ⚠️️ This function should be added to UITestSugar.
    * - Note: ref: https://stackoverflow.com/questions/43904798/how-to-dismiss-a-popover-in-a-ui-test (The selected link provides a solution for dismissing a popover in UI testing by using the XCUIApplication class and tapping on the "Dismiss" button.)
    */
    
   public func dismissPopup() {
      // Dismiss the popup by tapping the "Cancel" button
      otherElements["Cancel"].tap()
   }
}
#endif
