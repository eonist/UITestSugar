import Foundation

#if canImport(XCTest)
import XCTest
/**
 * Extension to XCUIElementQuery that provides additional functionality.
 */
extension XCUIElementQuery {
   /**
    * This method is used to fetch all the descendants of a query that are currently visible on the screen and can be interacted with by the user.
    * - Description: It returns an array of XCUIElement objects that are hittable, meaning they are not only visible but also enabled for user interaction.
    * - Returns: An array of XCUIElement objects that are currently hittable.
    * - Example: `XCUIApplication().descendants(matching: .any).hittableElements.count` returns the number of hittable elements.
    */
   public var hittableElements: [XCUIElement] {
      // Get an array of all hittable descendants of the current query
      QueryHelper.hittableElements(query: self)
   }
}
#endif
