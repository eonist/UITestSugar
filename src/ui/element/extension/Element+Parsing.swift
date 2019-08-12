import Foundation
import XCTest
/**
 * Parser
 */
extension XCUIElement {
   /**
    * Find first matching item in descendants based on condition (Works on immediate children and grandchildren and so on)
    * - Remark: Being able to do element?.firstDescendant(..) is powerfull when you need to chain calls. As you can't do that when you provide the elemnt as a parameter in the method call
    * ## Examples:
    * element.firstDescendant(type: .button) { $0.identifier = "someBtn" }
    */
   public func firstDescendant(type: XCUIElement.ElementType = .any, _ condition: ElementParser.MatchCondition) -> XCUIElement? {
      return ElementParser.firstDescendant(element: self, condition: condition, type: type)
   }
   /**
    * ## Examples:
    * element.firstDescendant { $0.identifier = "someBtn" }
    */
   public func firstDescendant(_ condition: ElementParser.MatchCondition) -> XCUIElement? {
      return self.firstDescendant(type: .any, condition)
   }
   /**
    * Find first matching item in children based on condition (Only works for immediate chilren not grandchildren etc)
    * - Remark: Being able to do element?.firstDescendant(..) is powerfull when you need to chain calls. As you cant do that when you provide the elemnt as a parameter in the method call
    */
   public func firstChild(type: XCUIElement.ElementType = .any, _ condition: ElementParser.MatchCondition) -> XCUIElement? {
      return ElementParser.firstChild(element: self, condition: condition, type: type)
   }
   /**
    * Convenient for doing element.firstChild { $0.identifier = "someBtn" }
    */
   public func firstChild(_ condition: ElementParser.MatchCondition) -> XCUIElement? {
      return self.firstChild(type: .any, condition)
   }
}
