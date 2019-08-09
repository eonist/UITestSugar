import Foundation
import XCTest
/**
 * Element Parser
 */
public class ElementParser {
   /**
    * Find first matching item in children based on condition (Only works for immediate chilren not grandchildren etc)
    * ## Examples:
    * let viewAllButton: XCUIElement? = firstChild(element: app, condition: { $0.identifier == "View all" })
    * - Parameter element: the element to target
    * - Parameter condition: the condition that the result must satisfy
    * - Parameter type: Make the search more speccific by providing a type
    */
   public static func firstChild(element: XCUIElement, condition: ElementParser.MatchCondition, type: XCUIElement.ElementType = .any) -> XCUIElement? {
      let children: [XCUIElement] = ElementParser.children(element: element, type: type)
      return children.first { condition($0) }
   }
   /**
    * Find first matching item in descendants based on condition (Works on immediate children and grandchildren and so on)
    * ## Examples:
    * let viewAllButton: XCUIElement? = firstDescendant(element: app, condition: { $0.identifier == "View all" })
    * - Parameter element: The element to find descendants in
    * - Parameter condition: the condition that the result must satisfy
    * - Parameter type: Only return descendats with this type
    * - Caution: ⚠️️ Careful setting the type. Something doesnt work correctly when type is set. (possible apple bug)
    */
   public static func firstDescendant(element: XCUIElement, condition: ElementParser.MatchCondition, type: XCUIElement.ElementType = .any) -> XCUIElement? {
      let descendants: [XCUIElement] = ElementParser.descendants(element: element, type: type)
      return descendants.first { condition($0) }
   }
   /**
    * Returns children elements for element (Only for immediate children)
    * - Parameter element: parent element for the children to be found
    * - Parameter type: When this is set to a speccific type it only returns children of a speccific type
    */
   public static func children(element: XCUIElement, type: XCUIElement.ElementType = .any) -> [XCUIElement] {
      let query: XCUIElementQuery = element.children(matching: type)
      return QueryParser.elements(query: query)
   }
   /**
    * Returns all descendants of an element of a speccific UIXUElement type
    * - Parameter element: The element to find descendants in
    * - Parameter type: Only return descendats with this type
    */
   public static func descendants(element: XCUIElement, type: XCUIElement.ElementType = .any) -> [XCUIElement] {
      let query: XCUIElementQuery = element.descendants(matching: type)
      return QueryParser.elements(query: query)
   }
}
