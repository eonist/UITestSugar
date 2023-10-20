#if canImport(XCTest)
import Foundation
import XCTest

public class QueryParser {
  /**
   * Returns the first element that matches the given identifier in the provided query.
   * 
   * ## Examples:
   * 
   * // Returns the first element with accessibility identifier "Featured Playlists-View all" in any descendant view of `app`
   * firstElement(query: app.descendants(matching: .any), identifier: "Featured Playlists-View all")
   * 
   * // Returns the first button with accessibility identifier "leftAlignedIconButton" in any descendant scroll view of `app`
   * firstElement(query: app.scrollViews.descendants(matching: .any), id: "leftAlignedIconButton", type: .button)
   * 
   * - Parameters:
   *   - type: The type of element to search for. Valid values are `.other` (UIView), `.cell` (UICollectionViewCell or UITableViewCell), and `.button` (UIButton).
   *   - identifier: The accessibility identifier to search for.
   *   - query: The query to target.
   * - Returns: The first element that matches the given identifier and type in the provided query, or `nil` if no such element is found.
   */
   public static func firstElement(query: XCUIElementQuery, id: String, type: XCUIElement.ElementType = .any) -> XCUIElement {
      // Get the element that matches the specified type and identifier
      let elementQuery: XCUIElement = query.element(
         matching: type, // The type of element to search for
         identifier: id // The identifier of the element to search for
      )
      return elementQuery.firstMatch
   }
   /**
    * Returns the first element of the specified type in the provided query.
    * - Parameters:
    *   - type: The type of element to search for. Valid values are `.button`, `.scrollBar`, `.checkButton`, and so on.
    *   - query: The query to target.
    * - Returns: The first element of the specified type in the provided query, or `nil` if no such element is found.
    * ## Example:
    * ```
    * // Returns the first button element in any descendant view of `app`
    * app.element(query: app.descendants(matching: .any), type: .button)
    * ```
    */
   public static func firstElement(query: XCUIElementQuery, type: XCUIElement.ElementType) -> XCUIElement {
      let elementQuery: XCUIElementQuery = query.children(matching: type)
      return elementQuery.element
   }
   /**
    * Beta ⚠️️
    * Returns an array of elements that match the provided labels in the given query.
    * - Parameters:
    *   - query: The query to target.
    *   - labels: The labels to search for.
    * - Returns: An array of elements that match the provided labels in the given query.
    * ## Example:
    * ```
    * // Returns an array of elements with labels "Sugar" and "500 g" in any child view of `app`
    * let elements = app.firstElement(query: app.children, labels: ["Sugar", "500 g"])
    * ```
    */
   public static func firstElement(query: XCUIElementQuery, labels: [String]) -> XCUIElement? {
      labels.map { (label: String) in
         // ⚠️️ Used to be CONTAINS, but thats partial and not exact etc
         let predicate: NSPredicate = .init(format: "label MATCHES %@", label)
         return query.containing(predicate)
         // Filter out any nil values from the array
      }.compactMap { $0 }.first?.element // Get the first non-nil element in the array
   }
   /**
    * Finds the first element in the provided query that has the specified label and taps it.
    * - Note: The link bellow is a blog post on the Realm Academy website titled "NSPredicate Cheatsheet". The post provides a comprehensive guide to using NSPredicate, which is a class used to define logical conditions used to constrain searches through collections of objects. The cheatsheet covers a wide range of topics, including basic syntax, comparison operators, compound predicates, and more advanced topics such as regular expressions and block predicates. The post is a useful resource for iOS developers who want to learn more about using NSPredicate in their apps.
    * - Note: ref https://academy.realm.io/posts/nspredicate-cheatsheet/
    * ## Examples:
    * // Finds the first button element with label "Edit list" in any descendant view of `app` and taps it, waiting up to 5 seconds for the element to appear
    * firstElement(app.descendants().buttons, label: "Edit list").tap(waitForExistence: 5)
    * - Parameters:
    *   - query: The query to target.
    *   - label: The label to search for.
    */
   public static func firstElement(_ query: XCUIElementQuery, label: String) -> XCUIElement {
      // ⚠️️ Used to be CONTAINS, but thats partial and not exact etc
      let predicate: NSPredicate = .init(format: "label MATCHES %@", label)
      let elementQuery: XCUIElementQuery = query.containing(predicate)
      return elementQuery.firstMatch
   }
   /**
    * Returns the first element in the given query that has a title matching the specified string.
    * - Parameter query: The query to search within.
    * - Parameter title: The title to match against.
    * - Returns: The first matching element, or nil if no matches were found.
    */
   public static func firstElement(_ query: XCUIElementQuery, title: String) -> XCUIElement {
      let predicate: NSPredicate = .init(format: "title MATCHES %@", title)
      let elementQuery: XCUIElementQuery = query.containing(predicate)
      return elementQuery.firstMatch
   }
   /**
    * Returns the first element in the given query that has a value matching the specified string.
    * - Parameter query: The query to search within.
    * - Parameter value: The value to match against.
    * - Returns: The first matching element, or nil if no matches were found.
    */
   public static func firstElement(_ query: XCUIElementQuery, value: String) -> XCUIElement {
      let predicate: NSPredicate = .init(format: "value MATCHES %@", value)
      let elementQuery: XCUIElementQuery = query.containing(predicate)
      return elementQuery.firstMatch
   }
   /**
    * Returns an array of elements that match the specified query and type.
    * - Important: ⚠️️ You can use the native `.allElementsBoundByIndex` method or `XCUIApplication.init().children(matching: .button)` instead of this method.
    * - Important: ⚠️️ you can use the native: `XCUIApplication.init().children(matching: .button)` instead of this method
    * - Parameters:
    *   - query: The query to search within.
    *   - type: The type of element to filter against.
    * - Returns: An array of elements that match the specified query and type.
    * ## Example:
    * ```
    * let app = XCUIApplication()
    * let buttons = QueryParser.elements(query: app.children, type: .button)
    * ```
    */
   public static func elements(query: XCUIElementQuery, type: XCUIElement.ElementType = .any) -> [XCUIElement] {
      (0..<query.count).indices.map { (i: Int) in
         query.children(matching: type).element(boundBy: i) // bound by is a way to access element by index
      }
   }
   /**
    * Returns an array of elements that match the specified query and have labels matching any of the provided strings.
    * - Parameters:
    *   - query: The query to target.
    *   - strings: The strings to match against.
    *   - type: The type of element to filter against.
    * - Returns: An array of elements that match the specified query and have labels matching any of the provided strings.
    * ## Example:
    * ```
    * let app = XCUIApplication()
    * let elements = QueryParser.children(query: app.children, strings: ["Sugar", "500 g"], type: .any)
    * let element = elements.first // get the first matching element
    * element?.exists // true or false
    * element?.tap()
    * // Cell example
    * let cells = AppParser.children(query: app.children, strings: "Sugar", "500 g", .cells).element
    * cells.exists // true , false
    * cells.firstMatch.tap()
    */
   public static func children(query: XCUIElementQuery, strings: [String], type: XCUIElement.ElementType = .any) -> [XCUIElement] {
      let result: [[XCUIElement]] = strings.map { (string: String) in // Map over each string in the array
         let predicate: NSPredicate = .init(format: "label MATCHES %@", string) // Create a predicate to match the string
         let elementQuery: XCUIElementQuery = query.containing(predicate) // Create an element query with the predicate
         let elements: [XCUIElement] = QueryParser.elements(query: elementQuery) // Get the elements matching the query
         return elements // Return the elements
      }
      return result.flatMap { $0 } // Flatten the array of arrays and return the result
   }
}
#endif
// public static func firstElement(query: XCUIElementQuery, identifier: String, type: XCUIElement.ElementType = .any) -> XCUIElement? {
//    let elements: [XCUIElement] = QueryParser.elements(query: query, type: type)
//    return elements.first { $0.identifier == identifier }
// }
