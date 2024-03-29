import Foundation
#if canImport(XCTest)
import XCTest
/*
* This is the ScreenShotMaker class, which provides functions for taking screenshots of windows and apps and attaching them to XCTestCases.
* - Fix: Maybe spin this class out into its own framework / repo?
*/
public final class ScreenShotMaker {
   /**
    * Screen-shot for iOS / macOS
    * - Abstract: This function takes a screenshot of either a window, an app, or the entire screen, depending on the parameters passed in.
    * - Description: Take a screenshot of a given app and add it to the test attachements.
    * - Remark: You can find screenshots in Xcode -> Report navigator -> select your test -> show gallery
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
       // If useWin is true and an app is provided, take a screenshot of the first window of the app
      if useWin, let win: XCUIElement = app?.windows.firstMatch {
         // Take a screenshot of the specified window
         return screenShotWindow(
            name: name, // The name to use for the screenshot
            testCase: testCase, // The test case that the screenshot is associated with
            window: win // The window to take the screenshot of
         )
      // If an app is provided, take a screenshot of the app
      } else if let app: XCUIApplication = app {
         // Take a screenshot of the entire app
         return screenShotApp(
            name: name, // The name to use for the screenshot
            testCase: testCase, // The test case that the screenshot is associated with
            app: app // The app to take the screenshot of
         )
      // Otherwise, take a screenshot of the entire screen
      } else {
         // Take a screenshot of the entire screen
         return screenShotScreen(
            name: name, // The name to use for the screenshot
            testCase: testCase // The test case that the screenshot is associated with
         )
      }
   }
   /**
    * Takes a screenshot of the entire screen.
    * - Parameters:
    *   - name: The name of the screenshot file.
    *   - testCase: The XCTestCase instance that the screenshot will be attached to.
    * - Returns: An XCUIScreenshot instance representing the screenshot taken.
    *
    * Example usage:
    * ```
    * let screenshot = ScreenShotMaker.screenShotScreen(name: "myScreenshot", testCase: self)
    * XCTAssertNotNil(screenshot)
    * ```
    */
   @discardableResult public static func screenShotScreen(name: String, testCase: XCTestCase?) -> XCUIScreenshot? {
      // Make sure that the testCase parameter is not nil
      guard let testCase: XCTestCase = testCase else {
         Swift.print("⚠️️ Err, ScreenShotMaker.makeScreenShot() - testcase is nil")
         return nil
      }
      // Take a screenshot of the entire screen
      let screenshot: XCUIScreenshot = XCUIScreen.main.screenshot()
      // Create an attachment with the specified name and screenshot
      let attachment: XCTAttachment = Self.attachment(
         name: name, // The name to use for the attachment
         screenshot: screenshot // The screenshot to attach
      )
      // Attach the screenshot to the test case (test directory)
      testCase.add(attachment)
      // Return the screenshot instance
      return screenshot
   }
   /**
    * Takes a screenshot of the provided app and saves it as an attachment to the provided XCTestCase.
    * - Parameters:
    *   - name: The name of the screenshot attachment.
    *   - testCase: The XCTestCase to which the screenshot attachment should be added.
    *   - app: The XCUIApplication instance to be screenshot.
    * - Returns: The XCUIScreenshot instance of the screenshot taken.
    *
    * Example usage:
    * ```
    * let app = XCUIApplication()
    * app.launch()
    * let screenshot = ScreenShotMaker.screenShotApp(name: "myScreenshot", testCase: self, app: app)
    * XCTAssertNotNil(screenshot)
    * ```
    */
   @discardableResult public static func screenShotApp(name: String, testCase: XCTestCase?, app: XCUIApplication) -> XCUIScreenshot? {
      // Check if the provided XCTestCase is not nil
      guard let testCase: XCTestCase = testCase else {
         Swift.print("⚠️️ Err, ScreenShotMaker.makeScreenShot() - testcase is nil")
         return nil
      }
      // Take a screenshot of the provided app
      let screenshot: XCUIScreenshot = app.screenshot()
      // Create an attachment with the specified name and screenshot
      let attachment: XCTAttachment = Self.attachment(
         name: name, // The name to use for the attachment
         screenshot: screenshot // The screenshot to attach
      )
      // Add the screenshot as an attachment to the provided XCTestCase (add screenshot to test directory)
      testCase.add(attachment)
      // Return the XCUIScreenshot instance of the screenshot taken
      return screenshot
   }
   /**
    * This function takes a screenshot of the provided window and saves it as an attachment to the provided XCTestCase.
    * - Parameters:
    *   - name: The name of the screenshot attachment.
    *   - testCase: The XCTestCase to which the screenshot attachment should be added.
    *   - window: The XCUIElement instance of the window to be screenshot.
    * - Returns: The XCUIScreenshot instance of the screenshot taken.
    */
   @discardableResult public static func screenShotWindow(name: String, testCase: XCTestCase?, window: XCUIElement) -> XCUIScreenshot? {
      // Check if the provided XCTestCase is not nil
      guard let testCase: XCTestCase = testCase else {
         // Print an error message indicating that the testcase is nil
         Swift.print("⚠️️ Err, ScreenShotMaker.makeScreenShot() - testcase is nil")
         // Return nil
         return nil
      }
      // Take a screenshot of the provided window
      let screenshot: XCUIScreenshot = window.screenshot()
      // Create an attachment with the specified name and screenshot
      let attachment: XCTAttachment = Self.attachment(
         name: name, // The name to use for the attachment
         screenshot: screenshot // The screenshot to attach
      )
      // Add the screenshot as an attachment to the provided XCTestCase
      testCase.add(attachment) // add screenshot to test directory
      // Return the XCUIScreenshot instance of the screenshot taken
      return screenshot
   }

   /**
    * This function creates an XCTAttachment instance from the provided screenshot and name.
    * - Parameters:
    *   - name: The name of the screenshot attachment.
    *   - screenshot: The XCUIScreenshot instance of the screenshot to be attached.
    * - Returns: The XCTAttachment instance of the screenshot attachment.
    */
   fileprivate static func attachment(name: String, screenshot: XCUIScreenshot) -> XCTAttachment {
      // Create an XCTAttachment instance from the provided screenshot and name
      let attachment: XCTAttachment = .init(screenshot: screenshot)
      // Set the name of the attachment based on the platform
      #if os(iOS)
      attachment.name = "Screenshot-\(name)-\(UIDevice.current.name).png"
      #else
      attachment.name = "Screenshot-\(name)-macOS.png"
      #endif
      // Set the lifetime of the attachment to keepAlways
      attachment.lifetime = .keepAlways
      // Return the XCTAttachment instance of the screenshot attachment
      return attachment
   }
}
#endif
