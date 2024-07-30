#if canImport(XCTest)
import Foundation
import XCTest
/**
 * Web
 */
extension ElementModifier {
   /**
    * Retrieves a `WebView` item based on the specified link title within an application.
    * - Description: This method searches for a web link within the application's web content using the provided title and returns the corresponding `WebView` item. It is particularly useful for interacting with hyperlinks in web-based interfaces.
    * - Important: ⚠️️ This function may not work if the link title is not unique. Consider using a different solution if you encounter this issue.
    * - Remark: This function uses the `links` property of `XCUIApplication` to return a `WebView` item for the specified title.
    * - Remark: You can also use the `Accessibility Inspector.app` in macOS or enable the iOS Simulator's Accessibility Inspector to inspect elements in the app.
    * - Remark: You can also use the `staticTexts` property of `XCUIApplication` to return a `StaticText` item for the specified content.
    * - Parameters:
    *   - app: A reference to the app.
    *   - title: The title of the link.
    * ## Examples:
    * let app = XCUIApplication()
    * let webView = ElementModifier.link(app: app, title: "Tweet this")
    * webView.tap()
    */
   public static func link(app: XCUIApplication, title: String) -> XCUIElement {
      // Return a `WebView` item for the specified title
      app.links[title]
   }
}
#endif
