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
    * - Abstract: Helps identify elements, especially when localization is involved.
    * - Parameters:
    *   - query: The query to debug. Can target children or descendants.
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
    * Debugs an element by printing information about its accessibility properties.
    * - Remark: There is also the native `debugDescription` property of `XCUIElement`.
    * - Parameters:
    *   - element: The element to debug.
    *   - indentation: The number of spaces to indent the output for readability.
    * - Returns: A dictionary containing the element's accessibility properties, including:
    *   - `id`: The `accessibilityIdentifier` property.
    *   - `aLabel`: The `accessibilityLabel` property.
    *   - `label`: The `label` property of the `XCUIElement`'s `button` object.
    *   - `type`: The type of the `XCUIElement`.
    *   - `title`: The `title` property of the `XCUIElement`.
    * - Example: `Swift.print(debug(element: app))` prints the accessibility properties of the `app` element.
    */
   public static func debug(element: XCUIElement, indentation: String = "") -> String {
          // Get the identifier of the element
    let id = element.identifier
    // Get the accessibility label of the element
    let aLable = String(describing: element.label) // ⚠️️ was .accessibilityLabel but seems it only works in iOS
    // Get the label of the element
    let lable = element.label
    // Get the type of the element
    let type = element.elementType.string
    // Get the title of the element
    let title = element.title
    // Combine the information into a string
    let str = "\(indentation)identifier:  \(id) accessibilityLabel:  \(aLable) label:  \(lable) type:  \(type) title:  \(title)"
    // Return the string
    return str
   }
   /**
    * Debugs multiple elements by printing their information to the console.
    * 
    * ## Examples:
    * let ancestry = ElementParser.ancestry(root: (0, app), condition: { $0.label == "Edit list" })
    * let elements: [XCUIElement] = ancestry?.map { $0.1 }
    * let debugStr: String = elements.debug()
    * Swift.print(debugStr)
    * 
    * - Parameter elements: An array of `XCUIElement` objects to be debugged.
    * 
    * - Returns: A string containing the debug information of the elements.
    */
   public static func debug(elements: [XCUIElement]) -> String {
      let strings: [String] = elements.map { ElementDebugger.debug(element: $0) }
      let str = strings.joined(separator: "\n")
      return str.suffix(2) == "\n" ? String(str.dropLast(2)) : str // removes the end linebreak \n
   }
   /**
    * Returns a string containing the hierarchy of an element and its descendants.
    * - Description: Helps debug a hierarchy
    * - Important: ⚠️️⚠️️⚠️️ This takes a long time to run if you pass app as the element. 1-3min etc
    * - Important: ⚠️️ Remember you also have the Acceccibility dialog in xcode where you can click an element and get hierarchy and info about it etc
    * - Remark: logs can get messy with `UITesting, a way to see the hierarchy more clearly is to use the filter filed and filter for the "-" char
    * - Remark: Instead of printing directly, wer rather return a string that can be printed, because UITesting is so messy for the log
    * - Fixme: ⚠️️ There is too much linebreaks in the output, clean it up
    * ## Examples:
    * let hierarchyStr: String = ElementDebugger.debugHierarchy(element: app, type: .any, indentationLevel: 1)
    * Swift.print("Hierarchy: \n" + hierarchyStr)
    * - Parameters:
   *   - element: The root element of the hierarchy.
   *   - type: The element type to drill down against. More specific means less wasted CPU.
   *   - indentationLevel: The indentation level used to make the log read more like a hierarchy. The more indentation, the further down in the hierarchy the item is.
   * 
   * - Returns: A string containing the hierarchy of the element and its descendants.
    */
   public static func debugHierarchy(element: XCUIElement, type: XCUIElement.ElementType = .any, indentationLevel: Int = 1) -> String {
      let children: [XCUIElement] = element.children(matching: type).allElementsBoundByIndex // get all children of the element that match the given type
      let str: String = children.map { // map each child to a string representation of its hierarchy
         let indentationLevel: Int = indentationLevel + 1 // increment the indentation level for the child
         let identation: String = .init(repeating: "-", count: indentationLevel) // create a string of "-" characters to represent the indentation level
         let retVal1: String = debug(element: $0, indentation: identation) // get the string representation of the child element
         let retVal2: String = debugHierarchy(element: $0, type: type, indentationLevel: indentationLevel) // recursively call debugHierarchy on the child element to get its descendants' hierarchy
         return retVal1 + (retVal2.isEmpty ? "" : "\n" + retVal2) // concatenate the string representations of the child element and its descendants' hierarchy
      }.joined(separator: "\n") // join the string representations of all children with a line break
      return str.suffix(2) == "\n" ? String(str.dropLast(2)) : str // remove the last line break from the string if it exists
   }
}
/**
 * Extension
 */
extension Array where Element: XCUIElement {
   public func debug() -> String {
      ElementDebugger.debug(elements: self)
   }
}
#endif
