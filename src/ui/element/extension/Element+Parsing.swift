import Foundation
import XCTest
/**
 * Parser
 */
extension XCUIElement {
   /**
    * Find first matching item in descendants based on condition (Works on immediate children and grandchildren and so on)
    * - Remark: Being able to do element?.firstDescendant(..) is powerfull when you need to chain calls. As you can't do that when you provide the elemnt as a parameter in the method call
    */
   public func firstDescendant(_ condition: ElementParser.MatchCondition, type: XCUIElement.ElementType = .any) -> XCUIElement? {
      return ElementParser.firstDescendant(element: self, condition: condition, type: type)
   }
   /**
    * Convenient for doing element.firstDescendant { $0.identifier = "someBtn" }
    */
   public func firstDescendant(_ condition: ElementParser.MatchCondition) -> XCUIElement? {
      return self.firstDescendant(condition, type: .any)
   }
   /**
    * Find first matching item in children based on condition (Only works for immediate chilren not grandchildren etc)
    * - Remark: Being able to do element?.firstDescendant(..) is powerfull when you need to chain calls. As you cant do that when you provide the elemnt as a parameter in the method call
    */
   public func firstChild(_ condition: ElementParser.MatchCondition, type: XCUIElement.ElementType = .any) -> XCUIElement? {
      return ElementParser.firstChild(element: self, condition: condition, type: type)
   }
   /**
    * Convenient for doing element.firstChild { $0.identifier = "someBtn" }
    */
   public func firstChild(_ condition: ElementParser.MatchCondition) -> XCUIElement? {
      return self.firstChild(condition, type: .any)
   }
}
