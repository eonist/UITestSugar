#if os(iOS)
#endif
import Foundation
import XCTest

public class QueryParser {
   /**
    * Returns first element by identifier
    * ## Examples:
    * firstElement(query: app.descendants(matching: .any), identifier: "Featured Playlists-View all")
    * firstElement(query: app.scrollViews.descendants(matching: .any), id: "leftAlignedIconButton", type: .button)
    * - Parameters:
    *   - type: .other (UIView), .cell (UICollectionViewCell or UITableViewCell), .button (UIButton)
    *   - id: The accessibility identifier
    *   - query: The query to target
    */
   public static func firstElement(query: XCUIElementQuery, id: String, type: XCUIElement.ElementType = .any) -> XCUIElement {
      query.element(matching: type, identifier: id).firstMatch
   }
   /**
    * Returns element of ElementType
    * - Parameters:
    *   - type: .button, .scrollBar, .checkButton etc
    *   - query: The query to target
    * ## Example:
    * app.element(query: app.children, type: .button)
    */
   public static func firstElement(query: XCUIElementQuery, type: XCUIElement.ElementType) -> XCUIElement {
      query.children(matching: type).element
   }
   /**
    * Beta warn
    * ## Example:
    * let firstElement = app.firstElement(query: app.children, labels: ["Sugar", "500 g"]).first?.element
    * firstElement.tap()
    * - Parameters:
    *   - query: The query to target
    *   - labels: Labels to search for
    */
   public static func firstElement(query: XCUIElementQuery, labels: [String]) -> XCUIElement? {
      labels.map { label in
         query.containing(NSPredicate(format: "label CONTAINS %@", label))
      }.compactMap { $0 }.first?.element
   }
   /**
    * Find the first match that has a lable
    * ## Examples:
    * firstElement(app.descendants().buttons, label: "Edit list").tap(waitForExistance: 5)
    * - Parameters:
    *   - query: The query to target
    *   - label: Label to search for
    */
   public static func firstElement(_ query: XCUIElementQuery, label: String) -> XCUIElement {
      query.containing(NSPredicate(format: "label CONTAINS %@", label)).firstMatch
   }
   /**
    * Returns elements in query
    * - Parameters:
    *   - query: the search query to match parent element
    *   - type: Filter against a speccific type to get a more presice result
    * - Important: ⚠️️ you can use the native: .allElementsBoundByIndex, there is also one for only items with accessibility
    * - Important: ⚠️️ you can use the native: XCUIApplication.init().children(matching: .button) instead of this method
    * ## Example:
    * QueryParser.elements(query: app.children, type: .button)
    */
   public static func elements(query: XCUIElementQuery, type: XCUIElement.ElementType = .any) -> [XCUIElement] {
      (0..<query.count).indices.map { i in
         query.children(matching: type).element(boundBy: i) // bound by is a way to access element by index
      }
   }
   /**
    * Find element that has either of the labels provided in strings parameter
    * - Parameters:
    *   - query: The query to target
    *   - strings: The strings to match against
    *   - type: Filter against a speccific type
    * ## Examples:
    * let app = XCUIApplication()
    * let element: AppParser.filterElements(query: app.children, strings: ["Sugar", "500 g"], type: .any).element
    * element.exists // true , false
    * element.first.tap()
    * // Cell example
    * let cells = AppParser.children(query: app.children, strings: "Sugar", "500 g", .cells).element
    * cells.exists // true , false
    * cells.firstMatch.tap()
    */
   public static func children(query: XCUIElementQuery, strings: [String], type: XCUIElement.ElementType = .any) -> [XCUIElement] {
      let result: [[XCUIElement]] = strings.map { string in
         let predicate = NSPredicate(format: "label CONTAINS %@", string)
         let elementQuery: XCUIElementQuery = query.containing(predicate)
         let elements: [XCUIElement] = QueryParser.elements(query: elementQuery)
         return elements
      }
      return result.flatMap { $0 } // ⚠️️ Seems odd that flatmap cant be applied to strings, but somehow it wont work etc
   }
}
//   public static func firstElement(query: XCUIElementQuery, identifier: String, type: XCUIElement.ElementType = .any) -> XCUIElement? {
//      let elements: [XCUIElement] = QueryParser.elements(query: query, type: type)
//      return elements.first { $0.identifier == identifier }
//   }


