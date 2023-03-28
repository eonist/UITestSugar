import Foundation
#if canImport(XCTest)
import XCTest

private final class ScreenShotMaker {
	/**
	 * - Remark: You can find screenshots in Xcode -> Report navigator -> select your test
	 * - Remark: Or go to: DerivedData -> ProjectName... -> Logs -> Test -> find .xcresult -> Show Package Contents -> Attachments
	 * - Remark: Or search for the file `Screenshot` in deriveddata root folder
	 * - Note: ref: https://stackoverflow.com/a/56345842/5389500
	 * ## Examples:
	 * ScreenShotMaker.makeScreenShot(testCase: self) // Put this line in your UITests where you want the screenshot to be taken
	 */
	private static func makeScreenShot(app: XCUIApplication, name: String) { // of app: XCUIApplication,
    	let screenshot = XCUIScreen.main.screenshot()
		 // let screenshot = app.windows.firstMatch.screenshot()
    	let attachment = XCTAttachment(screenshot: screenshot)
		#if os(iOS)
        attachment.name = "Screenshot-\(name)-\(UIDevice.current.name).png"
        #else
        attachment.name = "Screenshot-\(name)-macOS.png"
        #endif
    	attachment.lifetime = .keepAlways
    	app.add(attachment)
	}
}
#endif
