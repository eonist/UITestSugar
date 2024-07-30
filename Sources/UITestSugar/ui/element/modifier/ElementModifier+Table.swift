#if canImport(XCTest)
import Foundation
import XCTest
/**
 * Table
 */
extension ElementModifier {
   /**
    * Pulls a `TableView` to refresh.
    * - Description: This method simulates a pull-to-refresh gesture on a specified table view. It is typically used to trigger data reloading in the table view by simulating a user's downward swipe gesture from the top of the table.
    * - Parameter tableElement: The table view element on which the pull-to-refresh gesture will be performed.
    * - Remark: This function uses the `coordinate(withNormalizedOffset:)` and `press(forDuration:thenDragTo:)` methods of `XCUIElement` to simulate a pull-to-refresh gesture on the specified table.
    * ## Examples:
    * pullToRefresh(tableElement: app.tables.element)
    */
   public static func pullToRefresh(tableElement: XCUIElement) {
      // Get the first cell in the table
      let firstCell: XCUIElement = tableElement.children(matching: .cell).firstMatch
      // Get the start coordinate of the pull-to-refresh gesture
      // - Fixme: ⚠️️ use .zero here?
      let start: XCUICoordinate = firstCell.coordinate(withNormalizedOffset: .init(dx: 0, dy: 0))
      // Get the end coordinate of the pull-to-refresh gesture
      let finish: XCUICoordinate = firstCell.coordinate(withNormalizedOffset: .init(dx: 0, dy: 6))
      // Simulate a pull-to-refresh gesture by pressing and dragging from the start coordinate to the end coordinate
      start.press(forDuration: 0, thenDragTo: finish)
   }
   /**
    * Retrieves a cell from a table at a specified index.
    * - Description: This method fetches a cell from a table based on its index. It is particularly useful when you need to interact with a specific cell in a table view during UI tests.
    * - Parameters:
    *   - element: The table element from which the cell will be retrieved.
    *   - idx: The zero-based index of the cell to retrieve.
    * - Returns: An `XCUIElement` representing the cell at the specified index.
    * - Remark: This function utilizes the `element(boundBy:)` method of `XCUIElementQuery` to access the cell at the given index.
    * ## Examples:
    * let app = XCUIApplication()
    * let table = app.tables.element
    * let cell = ElementModifier.cell(element: table, idx: 0)
    * - Note: The `idx` parameter is zero-based, meaning the first cell is at index 0, the second at index 1, and so on.
    */
   public static func cell(element: XCUIElement, idx: Int) -> XCUIElement {
      // Fetch and return the cell at the specified index from the table
      element.tables.cells.element(boundBy: idx)
   }
}
#endif
