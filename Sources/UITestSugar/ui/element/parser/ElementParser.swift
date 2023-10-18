#if canImport(XCTest)
import Foundation
import XCTest
/**
 * Element Parser
 */
public class ElementParser {}
/**
 * Beta ⚠️️
 */
extension ElementParser {
   /**
    * Finds the first matching item in children based on a condition.
    * - Parameters:
    *   - element: The element to target.
    *   - condition: The condition that the result must satisfy.
    *   - type: An optional parameter that makes the search more specific by providing a type.
    * - Remark: This function uses the `children(matching:)` method of `XCUIElement` to get the immediate children of the specified element, and the `allElementsBoundByIndex` property to get an array of all matching elements. It then returns the first element that satisfies the specified condition.
    * - Important: ⚠️️ This function may not work if the condition is not unique. Consider using a different solution if you encounter this issue.
    * ## Examples:
    * let app = XCUIApplication()
    * let viewAllButton: XCUIElement? = ElementParser.firstChild(element: app, condition: { $0.identifier == "View all" })
    */
   public static func firstChild(element: XCUIElement, condition: ElementParser.MatchCondition, type: XCUIElement.ElementType = .any) -> XCUIElement? {
      // Get the immediate children of the specified element that match the specified type
      // And return the first element that satisfies the specified condition
      element.children(matching: type).allElementsBoundByIndex.first { condition($0) }
   }
   /**
    * Finds the first matching item in descendants based on a condition.
    * - Parameters:
    *   - element: The element to find descendants in.
    *   - condition: The condition that the result must satisfy.
    *   - type: An optional parameter that makes the search more specific by providing a type.
    * - Remark: This function uses the `descendants(element:type:)` method of `ElementParser` to get all descendants of the specified element that match the specified type. It then returns the first element that satisfies the specified condition.
    * - Remark: Be careful when setting the type parameter, as there may be issues with it. This could be a possible Apple bug.
    * - Important: ⚠️️ This function may not work if the condition is not unique. Consider using a different solution if you encounter this issue.
    * ## Examples:
    * let app = XCUIApplication()
    * let viewAllButton: XCUIElement? = ElementParser.firstDescendant(element: app, condition: { $0.identifier == "View all" }) // find button with accessibility identifier
    * let button = ElementParser.firstDescendant(element: app, condition: { $0.label == "Detail" })
    * Swift.print("button?.label:  \(button?.label)") // "Detail"
    */
   public static func firstDescendant(element: XCUIElement, condition: ElementParser.MatchCondition, type: XCUIElement.ElementType = .any) -> XCUIElement? {
      // Get all descendants of the specified element that match the specified type
      // and return the first element that satisfies the specified condition
      ElementParser.descendants(element: element, type: type).first { condition($0) }
   }
   /**
    * Returns children elements for a specified element.
    * - Parameters:
    *   - element: The parent element for the children to be found.
    *   - type: An optional parameter that makes the search more specific by providing a type.
    * - Remark: This function uses the `children(matching:)` method of `XCUIElement` to get the immediate children of the specified element that match the specified type. It then returns an array of all matching elements.
    * - Remark: If `type` is not specified, this function returns all immediate children of the specified element.
    * ## Examples:
    * let app = XCUIApplication()
    * let buttons = ElementParser.children(element: app, type: .button)
    */
   public static func children(element: XCUIElement, type: XCUIElement.ElementType = .any) -> [XCUIElement] {
      // Get the immediate children of the specified element that match the specified type
      // and return an array of all matching elements
      element.children(matching: type).allElementsBoundByIndex
   }
   /**
    * Returns all descendants of an element of a specific `XCUIElement` type.
    * - Parameters:
    *   - element: The element to find descendants in.
    *   - type: An optional parameter that makes the search more specific by providing a type.
    * - Remark: This function uses the `descendants(matching:)` method of `XCUIElement` to get all descendants of the specified element that match the specified type. It then returns an array of all matching elements.
    * - Remark: If `type` is not specified, this function returns all descendants of the specified element.
    * ## Examples:
    * let app = XCUIApplication()
    * let buttons = ElementParser.descendants(element: app, type: .button)
    */
   public static func descendants(element: XCUIElement, type: XCUIElement.ElementType = .any) -> [XCUIElement] {
      // Get all descendants of the specified element that match the specified type
      // and return an array of all matching elements
      element.descendants(matching: type).allElementsBoundByIndex
   }
   /**
    * Returns all descendants of an element that match a specified condition and type.
    * - Fixme: ⚠️️ Make this for children too
    * - Parameters:
    *   - element: The element to find descendants in.
    *   - condition: The condition that the result must satisfy.
    *   - type: An optional parameter that makes the search more specific by providing a type.
    * - Remark: This function uses the `descendants(matching:)` method of `XCUIElement` to get all descendants of the specified element that match the specified type. It then returns an array of all matching elements that satisfy the specified condition.
    * - Remark: If `type` is not specified, this function returns all descendants of the specified element.
    * - Important: ⚠️️ This function may not work if the condition is not unique. Consider using a different solution if you encounter this issue.
    * ## Examples:
    * let app = XCUIApplication()
    * let buttons = ElementParser.descendants(element: app, condition: { $0.label == "Submit" }, type: .button)
    */
   public static func descendants(element: XCUIElement, condition: ElementParser.MatchCondition, type: XCUIElement.ElementType = .any) -> [XCUIElement] {
      // Get all descendants of the specified element that match the specified type
      // and filter the array to only include elements that satisfy the specified condition
      element.descendants(matching: type).allElementsBoundByIndex.filter { condition($0) }
   }
}
#endif
