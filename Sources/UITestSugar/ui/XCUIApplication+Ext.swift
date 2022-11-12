import Foundation
#if canImport(XCTest)
import XCTest

extension XCUIApplication {
   /**
    * - Fixme: ⚠️️ Add to UITestSugar
    * - Note: ref: https://stackoverflow.com/questions/43904798/how-to-dismiss-a-popover-in-a-ui-test
    */
   public func dismissPopup() {
      // - Fixme: ⚠️️ this might not work
      otherElements["Cancel"].tap()
   }
}
#endif
