#if canImport(XCTest)
import Foundation
import XCTest
/**
 * Table
 */
extension ElementModifier {
   /**
    * Pulls a `TableView` to refresh.
    * - Parameter tableElement: The table to pull-refresh.
    * - Remark: This function uses the `coordinate(withNormalizedOffset:)` and `press(forDuration:thenDragTo:)` methods of `XCUIElement` to simulate a pull-to-refresh gesture on the specified table.
    * ## Examples:
    * pullToRefresh(tableElement: app.tables.element)
    */
   public static func pullToRefresh(tableElement: XCUIElement) {
      // Get the first cell in the table
      let firstCell: XCUIElement = tableElement.children(matching: .cell).firstMatch
      // Get the start coordinate of the pull-to-refresh gesture
      // fix: use .zero here?
      let start: XCUICoordinate = firstCell.coordinate(withNormalizedOffset: .init(dx: 0, dy: 0))
      // Get the end coordinate of the pull-to-refresh gesture
      let finish: XCUICoordinate = firstCell.coordinate(withNormalizedOffset: .init(dx: 0, dy: 6))
      // Simulate a pull-to-refresh gesture by pressing and dragging from the start coordinate to the end coordinate
      start.press(forDuration: 0, thenDragTo: finish)
   }
   /**
    * Returns a cell at a specified index in a table.
    * - Parameters:
    *   - element: The element to search from.
    *   - idx: The index of the cell to return.
    * - Returns: An `XCUIElement` representing the cell at the specified index.
    * - Remark: This function uses the `element(boundBy:)` method of `XCUIElementQuery` to return the cell at the specified index in the table.
    * ## Examples:
    * let app = XCUIApplication()
    * let table = app.tables.element
    * let cell = ElementModifier.cell(element: table, idx: 0)
    * - Note: The `idx` parameter is zero-based, so the first cell has an index of 0, the second cell has an index of 1, and so on.
    */
   public static func cell(element: XCUIElement, idx: Int) -> XCUIElement {
      // Return the cell at the specified index in the table
      element.tables.cells.element(boundBy: idx)
   }
}
#endif
