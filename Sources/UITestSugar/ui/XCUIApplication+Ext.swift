import Foundation
import XCTest

extension XCUIApplication {
   /**
    * - Fixme: ⚠️️ Add to UITestSugar
    * - Note: ref: https://stackoverflow.com/questions/43904798/how-to-dismiss-a-popover-in-a-ui-test
    */
   public func dismissPopup() {
      otherElements["dismiss popup"].tap()
   }
}
