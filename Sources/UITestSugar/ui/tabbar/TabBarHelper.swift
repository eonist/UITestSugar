#if canImport(XCTest)
import XCTest

public class TabBarHelper {
   /**
    * Retrieves a tabBar button by its name.
    * - Description: This method fetches a tabBar button using its accessibility identifier, which should match the name of the tabbar item. It is designed to facilitate the interaction with tabBar buttons during UI testing by providing a direct way to access these elements.
    * - Remark: It is advisable to manage tabBar item names through an enumeration for better maintainability, such as `enum TabButtonType: String { case homeButton, exploreButton, searchButton, myCollectionButton }`.
    * - Remark: Alternatively, tabBar buttons can be accessed using their labels or identifiers directly in the UI tests, for example: `app.descendants(matching: .staticText).allElementsBoundByIndex.first { $0.label == "tabBtn1"}` or `app.tabBars.buttons["Favorites"].tap(waitForExistence: 5, waitAfter: 2)`.
    * ## Example:
    * TabBarHelper.tabButton(tabButtonName: "homeButton").tap()
    * - Parameter tabButtonName: The name of the tabbar item to return.
    */
   public static func tabButton(tabButtonName: String) -> XCUIElement {
      // Return the tabBar button with the specified name
      XCUIApplication().firstDescendant(type: .button, id: tabButtonName)
   }
   /**
    * Retrieves a tabBar button by its index.
    * - Description: This method fetches a tabBar button based on its position within the tabBar. The index is zero-based, meaning that the first button is at index 0. This method is particularly useful for UI testing where direct interaction with tabBar buttons based on their order is required.
    * - Remark: This function searches for the button by its index in the tabBars query.
    * - Remark: Utilizing this function allows testers to programmatically interact with tabBar buttons, verifying their presence and functionality within the app.
    * ## Example:
    * TabBarHelper.tabButton(idx: 0).tap()
    * - Parameter idx: The zero-based index of the tabBar button to retrieve.
    */
   public static func tabButton(idx: Int) -> XCUIElement {
      // Get the `tabBars` query for the current application
      let tabBarsQuery: XCUIElementQuery = XCUIApplication().tabBars
      // Get the button element at the specified index in the `tabBars` query
      let uiElement: XCUIElement = tabBarsQuery.buttons.element(boundBy: idx)
      // Return the button element
      return uiElement
   }
}
#endif
