#if canImport(XCTest)
import Foundation
import XCTest
/**
 * Scrolling
 */
extension XCUIElement {
   /**
    * Scrolling
    * - Parameters:
    *   - dir: - Fixme: ⚠️️ doc
    *   - searchCondition: - Fixme: ⚠️️ doc
    */
   @discardableResult public func scrollTo(dir: ElementModifier.Direction, searchCondition: ElementParser.MatchCondition) -> XCUIElement {
      ElementModifier.scrollTo(element: self, dir: dir, searchCondition: searchCondition)
      return self
   }
   /**
    * Scrolling (beta)
    * - Parameter element: - Fixme: ⚠️️ doc
    */
   @discardableResult public func scrollToElement(element: XCUIElement, dir: ElementModifier.Direction = .up) -> XCUIElement {
      ElementModifier.scrollToElement(parent: self, element: element, dir: dir)
      return self
   }
   /**
    * Scrolling (beta)
    * - Parameter searchCondition: - Fixme: ⚠️️
    */
   @discardableResult public func scrollTo(searchCondition: ElementParser.MatchCondition) -> XCUIElement {
      ElementModifier.scrollToElement(element: self, searchCondition: searchCondition)
      return self
   }
}
#endif
