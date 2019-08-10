import Foundation
import XCTest
/**
 * Text
 */
extension XCUIElement {
   /**
    * Removes any current text in the field before typing in the new value
    * - Parameter text: the text to enter into the field
    */
   public func clearAndTypeText(text: String) {
      ElementModifier.clearAndTypeText(element: self, text: text)
   }
}
/**
 * Scrolling
 */
extension XCUIElement {
   /**
    * Scrolling
    */
   public func scrollToElement(element: XCUIElement) {
      ElementModifier.scrollToElement(parent: self, element: element)
   }
}
/**
 * Tapping
 */
extension XCUIElement {
   /**
    * Helps to tap things that dont work with regular .tap() calls. as .tap() calls must be on .isHittable items
    */
   public func forceTapElement() {
      if self.isHittable {
         self.tap()
      } else {
         let coordinate: XCUICoordinate = self.coordinate(withNormalizedOffset: .init(dx: 0.0, dy: 0.0))
         coordinate.tap()
      }
   }
}
/**
 * Assert
 */
extension XCUIElement {
   /**
    * Asert if exists and is visible in window
    */
   public func doesExistAndIsVisible(timeOut: Double) -> Bool {
      return ElementAsserter.existsAndVisible(element: self, timeout: timeOut)
   }
   /**
    * Asserts if an item is visible
    */
   public var isVisible: Bool { return ElementAsserter.isVisibleInWindow(element: self) }
}
/**
 * Parser
 */
extension XCUIElement {
   /**
    * Find first matching item in descendants based on condition (Works on immediate children and grandchildren and so on)
    * - Remark: Being able to do element?.firstDescendant(..) is powerfull when you need to chain calls. As you cant do that when you provide the elemnt as a parameter in the method call
    */
   public func firstDescendant(_ condition: ElementParser.MatchCondition, type: XCUIElement.ElementType = .any) -> XCUIElement? {
      return ElementParser.firstDescendant(element: self, condition: condition)
   }
   /**
    * Find first matching item in children based on condition (Only works for immediate chilren not grandchildren etc)
    * - Remark: Being able to do element?.firstDescendant(..) is powerfull when you need to chain calls. As you cant do that when you provide the elemnt as a parameter in the method call
    */
   public func firstChild(_ condition: ElementParser.MatchCondition, type: XCUIElement.ElementType = .any) -> XCUIElement? {
      let children: [XCUIElement] = ElementParser.children(element: self, type: type)
      return children.first { condition($0) }
   }
}
