import Foundation
#if canImport(XCTest)
import XCTest

public final class ScreenShotMaker {
	/**
	 * - Remark: You can find screenshots in Xcode -> Report navigator -> select your test
	 * - Remark: Or go to: DerivedData -> ProjectName... -> Logs -> Test -> find .xcresult -> Show Package Contents -> Attachments
	 * - Remark: Or search for the file `Screenshot` in deriveddata root folder
	 * - Note: ref: https://stackoverflow.com/a/56345842/5389500
	 * ## Examples:
	 * ScreenShotMaker.makeScreenShot() // Put this line in your UITests where you want the screenshot to be taken
	 */
	public static func makeScreenShot(testCase: XCTestCase) {
    	let screenshot = XCUIScreen.main.screenshot()
    	let fullScreenshotAttachment = XCTAttachment(screenshot: screenshot)
    	fullScreenshotAttachment.lifetime = .keepAlways
    	testCase.add(fullScreenshotAttachment)
	}
}
#endif
