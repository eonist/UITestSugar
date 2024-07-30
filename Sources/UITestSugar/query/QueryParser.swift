#if canImport(XCTest)
import Foundation
import XCTest

public class QueryParser {
  /**
   * Returns the first element that matches the given identifier in the provided query.
   * - Description: This function is used to find the first element that matches a given identifier within a specified query. It is particularly useful when you need to locate a specific UI element within a larger set of elements, such as a button within a form or a cell within a table. The function takes in three parameters: the query to search within, the identifier of the element to find, and the type of the element. The type parameter is optional and defaults to `.any`, which means it will match any type of element. If no matching element is found, the function returns `nil`.
   * ## Examples:
   * // Returns the first element with accessibility identifier "Featured Playlists-View all" in any descendant view of `app`
   * firstElement(query: app.descendants(matching: .any), identifier: "Featured Playlists-View all")
   * // Returns the first button with accessibility identifier "leftAlignedIconButton" in any descendant scroll view of `app`
   * firstElement(query: app.scrollViews.descendants(matching: .any), id: "leftAlignedIconButton", type: .button)
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
    * This function is used to find and return the first element of a specified type within a given query. 
    * - Description: It is particularly useful when you need to locate a specific type of UI element within a larger set of elements.
    * - Abstract: This function is used to find the first element of a specific type within a given query. It is particularly useful when you need to locate a specific UI element within a larger set of elements, such as a button within a form or a cell within a table. The function takes in two parameters: the query to search within and the type of the element to find. The type parameter is optional and defaults to `.any`, which means it will match any type of element. If no matching element is found, the function returns `nil`.
    * - Parameters:
    *   - type: The type of element to search for. This can be any valid XCUIElement.ElementType such as `.button`, `.scrollBar`, `.checkButton`, etc.
    *   - query: The XCUIElementQuery within which to search for the element.
    * - Returns: The first element of the specified type in the provided query. If no such element is found, the function returns `nil`.
    * ## Example:
    * ```
    * // This example returns the first button element in any descendant view of `app`
    * app.element(query: app.descendants(matching: .any), type: .button)
    * ```
    */
   public static func firstElement(query: XCUIElementQuery, type: XCUIElement.ElementType) -> XCUIElement {
      let elementQuery: XCUIElementQuery = query.children(matching: type)
      return elementQuery.element
   }
   /**
    * ⚠️️ Beta ⚠️️
    * This function is used to find and return an array of elements that match the provided labels within a given query.
    * - Description: It is particularly useful when you need to locate specific UI elements within a larger set of elements based on their labels. For example, you might want to find all buttons with a certain label within a form or all cells with a certain label within a table. The function takes in two parameters: the query to search within and the labels of the elements to find. If no matching elements are found, the function returns an empty array.
    * - Parameters:
    *   - query: The XCUIElementQuery within which to search for the elements.
    *   - labels: An array of labels to search for.
    * - Returns: An array of elements that match the provided labels in the given query. If no such elements are found, the function returns an empty array.
    * ## Example:
    * ```
    * // This example returns an array of elements with labels "Sugar" and "500 g" in any child view of `app`
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
    * This function identifies the first element in the provided query that matches the specified label and performs a tap action on it.
    * - Description: This function is particularly useful in UI testing where you need to simulate user interactions with the interface. It uses NSPredicate, a powerful class that defines logical conditions to constrain searches through collections of objects. For a comprehensive guide on using NSPredicate, refer to the blog post titled "NSPredicate Cheatsheet" on the Realm Academy website. The post covers a wide range of topics, including basic syntax, comparison operators, compound predicates, and more advanced topics such as regular expressions and block predicates. Here is the link: https://academy.realm.io/posts/nspredicate-cheatsheet/
    * - Note: The link bellow is a blog post on the Realm Academy website titled "NSPredicate Cheatsheet". The post provides a comprehensive guide to using NSPredicate, which is a class used to define logical conditions used to constrain searches through collections of objects. The cheatsheet covers a wide range of topics, including basic syntax, comparison operators, compound predicates, and more advanced topics such as regular expressions and block predicates. The post is a useful resource for iOS developers who want to learn more about using NSPredicate in their apps.
    * - Note: ref https://academy.realm.io/posts/nspredicate-cheatsheet/
    * - Example:
    * // This example finds the first button element with the label "Edit list" in any descendant view of `app` and taps it. The function waits up to 5 seconds for the element to appear before performing the tap action.
    * firstElement(app.descendants().buttons, label: "Edit list").tap(waitForExistence: 5)
    * - Parameters:
    *   - query: The XCUIElementQuery to search within.
    *   - label: The label of the element to find and tap.
    */
   public static func firstElement(_ query: XCUIElementQuery, label: String) -> XCUIElement {
      // ⚠️️ Used to be CONTAINS, but thats partial and not exact etc
      let predicate: NSPredicate = .init(format: "label MATCHES %@", label)
      let elementQuery: XCUIElementQuery = query.containing(predicate)
      return elementQuery.firstMatch
   }
   /**
    * This function is used to find the first element in the provided query that has a title matching the specified string.
    * - Description: It is particularly useful when you need to locate a specific UI element based on its title. For example, you might want to find a button with a certain title within a form. The function takes in two parameters: the query to search within and the title of the element to find. If no matching element is found, the function returns nil.
    * - Parameters:
    *   - query: The XCUIElementQuery within which to search for the element.
    *   - title: The title of the element to find.
    * - Returns: The first element that matches the provided title in the given query. If no such element is found, the function returns nil.
    */
   public static func firstElement(_ query: XCUIElementQuery, title: String) -> XCUIElement {
      let predicate: NSPredicate = .init(format: "title MATCHES %@", title)
      let elementQuery: XCUIElementQuery = query.containing(predicate)
      return elementQuery.firstMatch
   }
   /**
    * This function is used to find the first element in the provided query that has a value matching the specified string.
    * - Description: It is particularly useful when you need to locate a specific UI element based on its value. For example, you might want to find a slider with a certain value within a form. The function takes in two parameters: the query to search within and the value of the element to find. If no matching element is found, the function returns nil.
    * - Parameters:
    *   - query: The XCUIElementQuery within which to search for the element.
    *   - value: The value of the element to find.
    * - Returns: The first element that matches the provided value in the given query. If no such element is found, the function returns nil.
    */
   public static func firstElement(_ query: XCUIElementQuery, value: String) -> XCUIElement {
      let predicate: NSPredicate = .init(format: "value MATCHES %@", value)
      let elementQuery: XCUIElementQuery = query.containing(predicate)
      return elementQuery.firstMatch
   }
   /**
    * This function returns an array of elements that match a specified query and type.
    * - Description: This function is used to filter elements from a given query based on their type. It iterates over the query and returns an array of elements that match the specified type.
    * - Important: ⚠️️ Instead of this method, you can use the native `.allElementsBoundByIndex` method or `XCUIApplication.init().children(matching: .button)`.
    * - Parameters:
    *   - query: The XCUIElementQuery to search within.
    *   - type: The XCUIElement.ElementType to filter against. Default is .any.
    * - Returns: An array of XCUIElement that match the specified query and type.
    * ## Example:
    * ```
    * let app = XCUIApplication()
    * let buttons = QueryParser.elements(query: app.children, type: .button)
    * ```
    */
   public static func elements(query: XCUIElementQuery, type: XCUIElement.ElementType = .any) -> [XCUIElement] {
      return (0..<query.count).indices.map { index in 
         query.children(matching: type).element(boundBy: index) // bound by is a way to access element by index
      }
   }
   /**
    * This function returns an array of elements that match a specified query and have labels that match any of the provided strings.
    * - Description: This function is particularly useful when you need to locate specific UI elements based on their labels. It takes in three parameters: the query to search within, an array of strings to match against the labels of the elements, and the type of the elements to filter against. The function iterates over the query and returns an array of elements that match the specified type and have labels that match any of the provided strings.
    * - Parameters:
    *   - query: The XCUIElementQuery to search within.
    *   - strings: An array of strings to match against the labels of the elements.
    *   - type: The XCUIElement.ElementType to filter against. Default is .any.
    * - Returns: An array of XCUIElement that match the specified query, have labels that match any of the provided strings, and match the specified type.
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
