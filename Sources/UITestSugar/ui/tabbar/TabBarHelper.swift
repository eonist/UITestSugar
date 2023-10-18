#if canImport(XCTest)
import XCTest

public class TabBarHelper {
   /**
    * Returns tabBar buttons based on the name of the tabbar.item.
    * - Remark: This function returns the tabBar button with the specified name. It searches for the button by its accessibility identifier, which should be set to the name of the tabbar item.
    * - Remark: This function is useful for getting the tabBar buttons in UI testing. You can use it to interact with the tabBar buttons in your app and ensure that they are working correctly.
    * - Remark: It could be useful to store names of tabbar ids in an enum like: `TabButtonType: String { case homeButton, exploreButton, searchButton, myCollectionButton }`
    * - Remark: You can also use the following code to get the tabBar button with the specified name: `app.descendants(matching: .staticText).allElementsBoundByIndex.first { $0.label == "tabBtn1"}` or `app.tabBars.buttons["Favorites"].tap(waitForExistence: 5, waitAfter: 2)`
    * ## Example:
    * TabBarHelper.tabButton(tabButtonName: "homeButton").tap()
    * - Parameter tabButtonName: The name of the tabbar item to return.
    */
   public static func tabButton(tabButtonName: String) -> XCUIElement {
      // Return the tabBar button with the specified name
      return XCUIApplication().firstDescendant(type: .button, id: tabButtonName)
   }
   /**
    * Returns tabBar buttons based on the index of the tabbar item.
    * - Remark: This function returns the tabBar button with the specified index. It searches for the button by its index in the tabBarsQuery.
    * - Remark: This function is useful for getting the tabBar buttons in UI testing. You can use it to interact with the tabBar buttons in your app and ensure that they are working correctly.
    * ## Example:
    * TabBarHelper.tabButton(idx: 0).tap()
    * - Parameter idx: The index of the tabbar item to return.
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
