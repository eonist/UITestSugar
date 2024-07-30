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
    * Finds the first child element that meets a specified condition.
    * This method searches through the immediate children of a given element and returns the first one that satisfies a provided condition. It is useful for locating specific UI elements within a parent element's direct children.
    * - Important: ⚠️️ This function may not work if the condition is not unique. Consider using a different solution if you encounter this issue.
    * - Remark: This function uses the `children(matching:)` method of `XCUIElement` to retrieve the immediate children of the specified element, and the `allElementsBoundByIndex` property to get an array of all matching elements. It then returns the first element that satisfies the specified condition.
    * - Parameters:
    *   - element: The parent element whose children are to be searched.
    *   - condition: A closure that defines the condition the child element must satisfy.
    *   - type: An optional parameter that specifies the type of the children to be searched, enhancing the specificity of the search.
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
    * Retrieves the first descendant of a specified element that meets a given condition.
    * This method navigates through all descendants of the provided element, filtering them by type if specified, and returns the first one that fulfills the defined condition.
    * - Important: ⚠️️ This function may return unexpected results if the condition is not unique. Consider using a more specific condition or a different method if this is a concern.
    * - Remark: This method utilizes the `descendants(element:type:)` function of `ElementParser` to fetch all descendants of the given element that match the specified type. It then evaluates these elements against the provided condition to find the first match.
    * - Remark: Exercise caution when specifying the type parameter, as incorrect usage may lead to unexpected behavior, potentially due to limitations or bugs within the framework.
    * - Parameters:
    *   - element: The root element whose descendants will be searched.
    *   - condition: A closure that defines the criteria the descendant must meet.
    *   - type: An optional parameter that specifies the type of descendants to include in the search, enhancing search specificity.
    * ## Examples:
    * let app = XCUIApplication()
    * let viewAllButton: XCUIElement? = ElementParser.firstDescendant(element: app, condition: { $0.identifier == "View all" }) // Search for a button with a specific accessibility identifier
    * let detailButton = ElementParser.firstDescendant(element: app, condition: { $0.label == "Detail" })
    * Swift.print("Detail button label: \(detailButton?.label)") // Outputs: "Detail"
    */
   public static func firstDescendant(element: XCUIElement, condition: ElementParser.MatchCondition, type: XCUIElement.ElementType = .any) -> XCUIElement? {
      // Get all descendants of the specified element that match the specified type
      // and return the first element that satisfies the specified condition
      ElementParser.descendants(element: element, type: type).first { condition($0) }
   }
   /**
    * Returns children elements for a specified element.
    * - Description: This method retrieves the immediate children of a given element, optionally filtered by a specific type. It is useful for accessing direct child elements in a structured and type-specific manner.
    * - Remark: This function uses the `children(matching:)` method of `XCUIElement` to get the immediate children of the specified element that match the specified type. It then returns an array of all matching elements.
    * - Remark: If `type` is not specified, this function returns all immediate children of the specified element.
    * - Parameters:
    *   - element: The parent element for the children to be found.
    *   - type: An optional parameter that makes the search more specific by providing a type.
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
    * - Description: This method retrieves all descendants of a given element that match a specified type, providing a comprehensive list of child elements within the element's hierarchy. It is particularly useful for identifying and interacting with specific types of UI components nested within complex UI structures.
    * - Remark: This function uses the `descendants(matching:)` method of `XCUIElement` to get all descendants of the specified element that match the specified type. It then returns an array of all matching elements.
    * - Remark: If `type` is not specified, this function returns all descendants of the specified element.
    * - Parameters:
    *   - element: The element to find descendants in.
    *   - type: An optional parameter that makes the search more specific by providing a type.
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
    * Retrieves all descendants of a specified element that meet a given condition and are of a specified type.
    * - Description: This method searches through all descendants of the provided element, filtering them based on a specified condition and type. It returns an array of elements that match these criteria, allowing for targeted interaction with specific UI components within a complex hierarchy.
    * - Important: ⚠️️ This function may not work effectively if the condition is not unique. Consider using a different solution if you encounter this issue.
    * - Remark: This function leverages the `descendants(matching:)` method of `XCUIElement` to obtain all descendants of the specified element that match the specified type. It then filters these elements to return only those that satisfy the specified condition.
    * - Remark: If `type` is not specified, this function defaults to returning all descendants of the specified element.
    * - Fixme: ⚠️️ Extend this functionality to also handle direct children of the specified element.
    * - Parameters:
    *   - element: The element whose descendants are to be searched.
    *   - condition: A closure defining the condition that must be met by the descendants.
    *   - type: An optional parameter that specifies the type of descendants to include in the search, enhancing search specificity.
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
