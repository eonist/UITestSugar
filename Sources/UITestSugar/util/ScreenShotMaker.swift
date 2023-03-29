import Foundation
#if canImport(XCTest)
import XCTest

public final class ScreenShotMaker {
   /**
    * - Remark: You can find screenshots in Xcode -> Report navigator -> select your test
    * - Remark: Or go to: DerivedData -> ProjectName... -> Logs -> Test -> find .xcresult -> Show Package Contents -> Attachments
    * - Remark: Or search for the file `Screenshot` in deriveddata root folder
    * - Note: Ref: https://stackoverflow.com/a/56345842/5389500
    * - Note: There is a xcode gallary feature to browse screenshots see: https://stackoverflow.com/a/74678917/5389500
    * Take a screenshot of a given app and add it to the test attachements.
    * - Parameters:
    *   - testCase: Needed to add the attachment
    *   - app: The app to take a screenshot of.
    *   - name: The name of the screenshot.
    * ## Examples:
    * ScreenShotMaker.makeScreenShot(testCase: self) // Put this line in your UITests where you want the screenshot to be taken
    */
   public static func makeScreenShot(name: String, testCase: XCTestCase?, app: XCUIApplication? = nil) {
      let screenshot = app?.screenshot() ?? XCUIScreen.main.screenshot()
      if screenshot == nil {
         Swift.print("screenshot: \(String(describing: screenshot))")
      }
      XCTAssertNotNil(screenshot)
      // let screenshot = app.windows.firstMatch.screenshot()
      let attachment = XCTAttachment(screenshot: screenshot)
      #if os(iOS)
      attachment.name = "Screenshot-\(name)-\(UIDevice.current.name).png"
      #else
      attachment.name = "Screenshot-\(name)-macOS.png"
      #endif
      attachment.lifetime = .keepAlways
      testCase?.add(attachment)
   }
}
#endif
