import Foundation
import XCTest

public class QueryAsserter {
   /**
    * ⚠️️ Beta ⚠️️
    */
   public static func waitFor(app: XCUIApplication, labelString:String, timeOut: Double = 5) {
      let label = app.staticTexts[labelString]
      let exists = NSPredicate(format: "exists == true")
      let testCase: XCTestCase = .init()
      testCase.expectation(for: exists, evaluatedWith: label, handler: nil)
      testCase.waitForExpectations(timeout: timeOut, handler: nil)
      XCTAssert(label.exists)
   }
}
