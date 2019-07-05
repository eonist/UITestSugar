import Foundation
import XCTest
/**
 * Debugger
 */
public class ElementDebugger {
   /**
    * Helps identify elements (Useful when there is localization involved)
    * ## Examples:
    * debugChildren(query: app.scrollViews.otherElements.buttons)
    * - Note: to debug descendants use the descendants call in the query
    * - Parameter query: Debug all elements of this query
    */
   public static func debug(query: XCUIElementQuery) {
      let elements: [XCUIElement] = query.allElementsBoundByIndex
      elements.forEach { debug(element: $0) }
   }
   /**
    * Helps debug an element
    * - Parameter element: The element to debug
    * - Parameter indentation: Used to indent the print, so debugging hierarchy becomes more readable
    */
   public static func debug(element: XCUIElement, indentation: String = "") {
      let id = element.identifier
      let aLable = String(describing: element.accessibilityLabel)
      let lable = element.label
      let type = element.elementType.string
      let title = element.title
      Swift.print("\(indentation)identifier:  \(id) accessibilityLabel:  \(aLable) label:  \(lable) type:  \(type) title:  \(title)")
   }
   /**
    * Helps debug a hierarchy
    * ## Examples:
    * ElementParser.debugHierarchy(element: app, type: .any, indentaionLevel: 1)
    * - Remark: logs can get messy with UITesting, a way to see the hierarchy more clearly is to use the filter filed and filter for the "-" char
    * - Fixme: ⚠️️ ⚠️️ ⚠️️ Instead of printing directly, rather return a string that can be printed, because UITesting is so messy for the log
    * - Parameter element: The root element of the hierarchy
    * - Parameter type: the element type to drill down against. More speccific means less wasted CPU
    * - Parameter indentationLevel: This is used to make the log read more like a hierachy. The more indentation the further down in the hierarchy the item is
    */
   public static func debugHierarchy(element: XCUIElement, type: XCUIElement.ElementType = .any, indentationLevel: Int = 1) {
      let children = element.children(matching: type).allElementsBoundByIndex
      children.forEach {
         let indentationLevel: Int = indentationLevel + 1
         let identation: String = .init(repeating: "-", count: indentationLevel)
         debug(element: $0, indentation: identation)
         debugHierarchy(element: $0, type: type, indentationLevel: indentationLevel) // keep traversing down the hierarchy
      }
   }
}
