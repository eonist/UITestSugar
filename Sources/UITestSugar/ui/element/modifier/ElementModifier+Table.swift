#if os(iOS)
import Foundation
import XCTest
/**
 * Table
 */
extension ElementModifier {
   /**
    * Pulls a tableview to refresh
    * - Parameter tableElement: The table to pull-refresh
    */
   public static func pullToRefresh(tableElement: XCUIElement) {
      let firstCell: XCUIElement = tableElement.children(matching: .cell).firstMatch
      let start = firstCell.coordinate(withNormalizedOffset: .init(dx: 0, dy: 0))
      let finish = firstCell.coordinate(withNormalizedOffset: .init(dx: 0, dy: 6))
      start.press(forDuration: 0, thenDragTo: finish)
   }
   /**
    * (Untested)
    * - Parameters:
    *   - element: The element to search from
    *   - idx: The index of the cell
    */
   public static func cell(element: XCUIElement, idx: Int) -> XCUIElement {
      element.tables.cells.element(boundBy: idx)
   }
}

#endif
