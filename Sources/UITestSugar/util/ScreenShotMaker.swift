import Foundation
#if canImport(XCTest)
import XCTest
/*
* This is the ScreenShotMaker class, which provides functions for taking screenshots of windows and apps and attaching them to XCTestCases.
* - Fix: Maybe spin this class out into its own framework / repo?
*/
public final class ScreenShotMaker {
   /**
    * Takes a screenshot of a specified app, window, or the entire screen for iOS/macOS testing.
    * - Abstract: This function captures a screenshot based on the provided parameters, which can target a specific app window, the entire app, or the entire screen. The screenshot is then attached to the specified XCTestCase.
    * - Description: Depending on the parameters, this function can capture a screenshot of a specific window within an app (useful for macOS), the entire app, or the entire screen. The screenshot is added to the test attachments, aiding in visual verification during automated testing.
    * - Remark: Screenshots can be accessed via Xcode's Report navigator by selecting your test and viewing the gallery.
    * - Remark: Alternatively, navigate to DerivedData -> ProjectName... -> Logs -> Test -> locate .xcresult -> Show Package Contents -> Attachments to find the screenshots.
    * - Remark: Screenshots can also be searched for in the DerivedData root folder by the file name `Screenshot`.
    * - Note: For more details on managing screenshots in Xcode, refer to: https://stackoverflow.com/a/56345842/5389500 and https://stackoverflow.com/a/74678917/5389500
    * - Note: Learn about creating screenshots in UI tests at: https://www.appsdeveloperblog.com/xcuiscreenshot-creating-screenshots-in-ui-test/
    * - Parameters:
    *   - testCase: The XCTestCase instance to which the screenshot will be attached. This parameter is optional to simplify calling conditions.
    *   - app: The application instance from which to capture the screenshot.
    *   - name: The designated name for the screenshot file.
    *   - useWin: A boolean flag to specify if only the window should be captured (relevant for macOS applications).
    * ## Examples:
    * ScreenShotMaker.makeScreenShot(testCase: self) // Use this line in your UITests at the point where a screenshot is required.
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
    * Takes a screenshot of the entire screen and attaches it to a specified XCTestCase.
    * - Description: This method captures a screenshot of the entire screen of the device. It is useful for verifying the overall UI layout in tests or capturing the state of the app for debugging purposes. The screenshot is then attached to the provided XCTestCase, allowing it to be reviewed later as part of the test results.
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
    * Captures a screenshot of the specified application and attaches it to the given XCTestCase.
    * - Description: This method takes a screenshot of the entire application as displayed on the device at the time of invocation. The screenshot is then attached to the specified XCTestCase, which can be useful for documentation or debugging purposes during automated testing.
    * - Parameters:
    *   - name: The name to be assigned to the screenshot attachment.
    *   - testCase: The XCTestCase instance where the screenshot will be attached.
    *   - app: The XCUIApplication instance from which the screenshot will be taken.
    * - Returns: An XCUIScreenshot object representing the captured screenshot.
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
    * Captures a screenshot of a specific window and attaches it to a test case.
    * - Description: This method captures the visual state of a specified window element within the application and creates an attachment for the given XCTestCase. This is particularly useful for documenting or debugging the appearance of specific windows during automated UI tests.
    * - Parameters:
    *   - name: The name to be assigned to the screenshot attachment.
    *   - testCase: The XCTestCase instance where the screenshot will be attached.
    *   - window: The XCUIElement representing the window to be captured.
    * - Returns: An XCUIScreenshot object representing the captured screenshot, or nil if the testCase is nil.
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
    * Creates an XCTAttachment instance using a screenshot and a specified name.
    * This method is useful for creating attachments from screenshots during UI testing, allowing these screenshots to be added to test cases for documentation or debugging purposes.
    * - Parameters:
    *   - name: The name to be assigned to the screenshot attachment.
    *   - screenshot: The XCUIScreenshot instance to be used for creating the attachment.
    * - Returns: An XCTAttachment created from the provided screenshot, named according to the specified parameter.
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
