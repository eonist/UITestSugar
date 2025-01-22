#if canImport(XCTest)
import Foundation
import XCTest
/**
 * Debugger
 * - Fixme: ⚠️️ Make debugStr, debugHeirarchyStr that returns string, and actual, debug calls that prints the debug string etc
 */
public class ElementDebugger {
   /**
    * Debug a query by printing information about its elements.
    * - Description: This method is used to debug a query by printing detailed information about each element in the query. It is particularly useful when dealing with localization.
    * - Parameters:
    *   - query: The query to debug. This can target either children or descendants of the current element.
    * - Examples:
    *   - `debug(query: app.scrollViews.otherElements.buttons)`
    *   - `debug(query: app.children)`
    *   - `debug(query: app.descendants())`
    * - Remarks: To debug descendants, use the `descendants()` call in the query.
    */
   public static func debug(query: XCUIElementQuery) -> String {
      let elements: [XCUIElement] = query.allElementsBoundByIndex // Get all elements
      return elements.map { debug(element: $0) }.joined(separator: "\n") // Print debug info for each element
   }
   /**
    * Provides a detailed overview of an element's accessibility properties.
    * - Remark: The native `debugDescription` property of `XCUIElement` can also be used for debugging.
    * - Parameters:
    *   - element: The element to be examined.
    *   - indentation: The number of spaces to indent the output for better readability.
    * - Returns: A dictionary containing the element's accessibility properties, including:
    *   - `id`: The `accessibilityIdentifier` property.
    *   - `aLabel`: The `accessibilityLabel` property.
    *   - `label`: The `label` property of the `XCUIElement`'s `button` object.
    *   - `type`: The type of the `XCUIElement`.
    *   - `title`: The `title` property of the `XCUIElement`.
    * - Example: `Swift.print(debug(element: app))` will output the accessibility properties of the `app` element.
    */
   public static func debug(element: XCUIElement, indentation: String = "") -> String {
      let id: String = element.identifier // Get the identifier of the element
      let aLable: String = .init(describing: element.label) // Get the accessibility label of the element ⚠️️ was .accessibilityLabel but seems it only works in iOS
      let lable: String = element.label // Get the label of the element
      let type: String = element.elementType.string // Get the type of the element
      let title: String = element.title // Get the title of the element
      let str: String = "\(indentation)identifier:  \(id) accessibilityLabel:  \(aLable) label:  \(lable) type:  \(type) title:  \(title)" // Combine the information into a string
      return str // Return the string
   }
   /**
    * Debugs an array of elements by generating a detailed string representation of their properties.
    * This method is useful when you need to inspect multiple elements at once, especially when troubleshooting UI tests.
    * ## Examples:
    * let ancestry = ElementParser.ancestry(root: (0, app), condition: { $0.label == "Edit list" })
    * let elements: [XCUIElement] = ancestry?.map { $0.1 }
    * let debugStr: String = elements.debug()
    * Swift.print(debugStr)
    * - Parameter elements: An array of `XCUIElement` objects to be debugged.
    * - Returns: A string containing the debug information of the elements. Each element's information is separated by a newline.
    */
   public static func debug(elements: [XCUIElement]) -> String {
      // Map each element to a debug string using the `debug` method of the `ElementDebugger` class
      let strings: [String] = elements.map { ElementDebugger.debug(element: $0) }
      // Join the debug strings into a single string separated by newlines
      let str = strings.joined(separator: "\n")
      return str.suffix(2) == "\n" ? String(str.dropLast(2)) : str // removes the end linebreak \n
   }
   /**
    * Generates a string representation of the hierarchy of an element and its descendants.
    * - Description: This method is useful for debugging the structure of a UI hierarchy.
    * - Important: ⚠️️⚠️️⚠️️ Be aware that this method can take a significant amount of time to execute if you pass the entire application as the element (1-3 minutes).
    * - Important: ⚠️️ Don't forget that Xcode's Accessibility Inspector also allows you to click on an element to view its hierarchy and other information.
    * - Remark: Logs can become cluttered when using `UITesting`. To make the hierarchy easier to read, consider filtering the logs for the "-" character.
    * - Remark: To avoid cluttering the logs, this method returns a string that can be printed, rather than printing directly.
    * - Fixme: ⚠️️ The output currently contains excessive line breaks. This should be cleaned up.
    * ## Examples:
    * let hierarchyStr: String = ElementDebugger.debugHierarchy(element: app, type: .any, indentationLevel: 1)
    * Swift.print("Hierarchy: \n" + hierarchyStr)
    * - Parameters:
    *   - element: The root element of the hierarchy.
    *   - type: The type of elements to include in the hierarchy. Specifying a more specific type can reduce CPU usage.
    *   - indentationLevel: The level of indentation used to format the output. Higher levels of indentation correspond to deeper levels in the hierarchy.
    * - Returns: A string representation of the hierarchy of the element and its descendants.
    */
   public static func debugHierarchy(element: XCUIElement, type: XCUIElement.ElementType = .any, indentationLevel: Int = 1) -> String {
      // ⚠️️ Recently refactored
      let children = element.children(matching: type).allElementsBoundByIndex
      var results = [String]()
      for child in children {
         let indentation = String(repeating: "-", count: indentationLevel + 1)
         let elementDescription = debug(element: child, indentation: indentation)
         results.append(elementDescription)
         let childHierarchy = debugHierarchy(element: child, type: type, indentationLevel: indentationLevel + 1)
         if !childHierarchy.isEmpty {
               results.append(childHierarchy)
         }
      }
      return results.joined(separator: "\n")
   }
}
/**
 * Extension
 */
extension Array where Element: XCUIElement {
   /**
    * This method is responsible for generating a debug string for the current element and all its descendants.
    * - Description: It leverages the `debug` method from the `ElementDebugger` class to create a comprehensive debug string for the elements.
    * - Returns: A string that contains debug information for the current element and all its descendants.
    */
   public func debug() -> String {
      // Call the `debug` method of the `ElementDebugger` class to generate a debug string for the elements
      ElementDebugger.debug(elements: self)
   }
}
#endif
