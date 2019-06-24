import Foundation
import XCTest
/**
 * Parser
 */
public class ElementParser {
   /**
    * Returns children elements for element
    * - Parameter element: parent element
    */
   public static func children(element: XCUIElement, type: XCUIElement.ElementType = .any) -> [XCUIElement] {
      let query: XCUIElementQuery = element.children(matching: type)
      return QueryParser.elements(query: query)
   }
   /**
    * Returns all children 
    */
   public static func descendants(element: XCUIElement, type: XCUIElement.ElementType = .any) -> [XCUIElement] {
      let query: XCUIElementQuery = element.descendants(matching: type)
      return QueryParser.elements(query: query)
   }
   /**
    * Helps identify elements (Useful when there is localization involved)
    * ## Examples:
    * debugChildren(query: app.scrollViews.otherElements.buttons)
    * - Note: to debug descendants use the descendants call in the query
    */
   public static func debug(query: XCUIElementQuery) {
      let elements = query.allElementsBoundByIndex
      elements.forEach {
         Swift.print("$0.identifier:  \($0.identifier)")
         Swift.print("$0.accessibilityLabel:  \(String(describing: $0.accessibilityLabel))")
         Swift.print("$0.label:  \($0.label)")
         Swift.print("$0.elementType:  \($0.elementType.rawValue)")
      }
   }
}
