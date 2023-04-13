import Foundation
#if canImport(XCTest)
import XCTest

public final class ScreenShotMaker {
   /**
    * Screen-shot for iOS / macOS
    * - Description: Take a screenshot of a given app and add it to the test attachements.
    * - Remark: You can find screenshots in Xcode -> Report navigator -> select your test
    * - Remark: Or go to: DerivedData -> ProjectName... -> Logs -> Test -> find .xcresult -> Show Package Contents -> Attachments
    * - Remark: Or search for the file `Screenshot` in deriveddata root folder
    * - Note: Ref: https://stackoverflow.com/a/56345842/5389500
    * - Note: There is a xcode gallery feature to browse screenshots see: https://stackoverflow.com/a/74678917/5389500
    * - Note: https://www.appsdeveloperblog.com/xcuiscreenshot-creating-screenshots-in-ui-test/
    * - Fixme: ⚠️️ clean up comments
    * - Parameters:
    *   - testCase: Needed to add the attachment (is optional to avoid guard in caller etc)
    *   - app: The app to take a screenshot of.
    *   - name: The name of the screenshot.
    *   - useWin: capture only window in app (relevant for macOS)
    * ## Examples:
    * ScreenShotMaker.makeScreenShot(testCase: self) // Put this line in your UITests where you want the screenshot to be taken
    */
   @discardableResult public static func makeScreenShot(name: String, testCase: XCTestCase?, app: XCUIApplication? = nil, useWin: Bool = false) -> XCUIScreenshot? {
      if useWin, let win = app?.windows.firstMatch {
         return screenShotWindow(name: name, testCase: testCase, window: win)
      } else if let app: XCUIApplication = app {
         return screenShotApp(name: name, testCase: testCase, app: app)
      } else {
         return screenShotScreen(name: name, testCase: testCase)
      }
   }
   /**
    * Screenshot screen
    */
   @discardableResult public static func screenShotScreen(name: String, testCase: XCTestCase?)  -> XCUIScreenshot? {
      guard let testCase = testCase else { Swift.print("⚠️️ Err, ScreenShotMaker.makeScreenShot() - testcase is nil"); return nil }
      let screenshot = XCUIScreen.main.screenshot()
      testCase.add(attachment(name: name, screenshot: screenshot)) // add screenshot to test directory
      return screenshot
   }
   /**
    * Screenshot app
    */
   @discardableResult public static func screenShotApp(name: String, testCase: XCTestCase?, app: XCUIApplication) -> XCUIScreenshot?  {
      guard let testCase = testCase else { Swift.print("⚠️️ Err, ScreenShotMaker.makeScreenShot() - testcase is nil"); return nil }
      let screenshot = app.screenshot()
      testCase.add(attachment(name: name, screenshot: screenshot)) // add screenshot to test directory
      return screenshot
   }
   /**
    * Screenshot window
    */
   @discardableResult static public func screenShotWindow(name: String, testCase: XCTestCase?, window: XCUIElement) -> XCUIScreenshot? {
      guard let testCase = testCase else { Swift.print("⚠️️ Err, ScreenShotMaker.makeScreenShot() - testcase is nil"); return nil }
      let screenshot = window.screenshot()
      testCase.add(attachment(name: name, screenshot: screenshot)) // add screenshot to test directory
      return screenshot
   }
   /**
    * Attachment
    */
   fileprivate static func attachment(name: String, screenshot: XCUIScreenshot) -> XCTAttachment {
      let attachment = XCTAttachment(screenshot: screenshot)
      #if os(iOS)
      attachment.name = "Screenshot-\(name)-\(UIDevice.current.name).png"
      #else
      attachment.name = "Screenshot-\(name)-macOS.png"
      #endif
      attachment.lifetime = .keepAlways
      return attachment
   }
}
#endif
