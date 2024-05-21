#if canImport(XCTest)
import Foundation
import XCTest
/**
 * Web
 */
extension ElementModifier {
   /**
    * Returns a `WebView` item for a specified title
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
