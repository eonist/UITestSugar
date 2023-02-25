#if canImport(XCTest)
import Foundation
import XCTest
/**
 * Web
 */
extension ElementModifier {
   /**
    * Return a `WebView` item for title
    * ## Examples:
    * link(app: XCUIApplication(), title: "Tweet this")
    * - Remark: you can also do things like: app.webViews.checkBoxes["id"].tap()
    * - Remark: you can also use the Accessibility Inspector.app in macos
    * - Remark: you can also enable the iOS Simulator's Accessibility Inspector
    * - Remark: you can also do: XCUIApplication().staticTexts["content"]
    * - Parameters:
    *   - app: A reference to the app
    *   - link: Could be the link text or id ⚠️️ testing needed
    */
   public static func link(app: XCUIApplication, title: String) -> XCUIElement {
      app.links[title]
   }
}
#endif
