import Foundation
import XCTest
/**
 * Parser (Descendant)
 */
extension XCUIElement {
   public typealias SearchType = (type: XCUIElement.ElementType, id: String?)
   /**
    * Returns an XCUIElement
    * ## Examples:
    * app.descendant((.table,nil),(.button,”refreshBtn”))
    */
   public func descendant(_ map: [SearchType]) -> XCUIElement {
      if map.count == 1, let search = map.first {
         return self.firstDescendant(type: search.type, id: search.id)
      } else if map.count > 1, let search: SearchType = map.first {
         let element = self.firstDescendant(type: search.type, id: search.id)
         let newMap = Array(map[1..<map.count])
         return element.descendant(newMap)
      } else {
         Swift.print("🚫 map is an empty array 🚫")// fatalError("🚫 map is an empty array 🚫")
         return self // the logic is that it will work with waiter calls
      }
   }
   /**
    * firstDescendant
    * ## Examples:
    * app.firstDescendant(type: .button).waitToAppear(5)?.tap(wait: 2)
    * app.firstDescendant(id: "someBtn").waitToAppear(5)?.tap(wait: 2)
    * app.firstDescendant(type: .button, id: "someBtn").waitToAppear(5)?.tap(wait: 2)
    */
   public func firstDescendant(type: XCUIElement.ElementType = .any, id: String? = nil) -> XCUIElement {
      if let id = id {
         return self.descendants(id: id, type: type).firstMatch
      } else {
         return self.descendants(matching: type).firstMatch
      }
   }
   /**
    * descendants
    */
   public func descendants(id: String, type: XCUIElement.ElementType = .any) -> XCUIElementQuery {
      return self.descendants(matching: type).matching(identifier: id)
   }
}
/**
 * Parser (Children)
 */
extension XCUIElement {
   /**
    * firstChild
    */
   public func firstChild(type: XCUIElement.ElementType = .any, id: String? = nil) -> XCUIElement {
      if let id = id {
         return self.children(id: id, type: type).firstMatch
      } else {
         return self.children(matching: type).firstMatch
      }
   }
   /**
    * children
    */
   public func children(id: String, type: XCUIElement.ElementType = .any) -> XCUIElementQuery {
      return self.children(matching: type).matching(identifier: id)
   }
}
/**
 * Beta (⚠️️ these won't work with waiter calls, but can be good for syncronouse exist calls ⚠️️)
 */
extension XCUIElement {
   /**
    * Find first matching item in descendants based on condition (Works on immediate children and grandchildren and so on)
    * - Remark: Being able to do element?.firstDescendant(..) is powerfull when you need to chain calls. As you can't do that when you provide the elemnt as a parameter in the method call
    * ## Examples:
    * element.firstDescendant(type: .button) { $0.identifier = "someBtn" }
    */
   private func firstDescendant(type: XCUIElement.ElementType = .any, _ condition: ElementParser.MatchCondition) -> XCUIElement? {
      return ElementParser.firstDescendant(element: self, condition: condition, type: type)
   }
   /**
    * ## Examples:
    * element.firstDescendant { $0.identifier = "someBtn" }
    */
   private func firstDescendant(_ condition: ElementParser.MatchCondition) -> XCUIElement? {
      return self.firstDescendant(type: .any, condition)
   }
   
   /**
    * ## Examples:
    * app.descendants(type:.button) { $0.identifier == "specialBtn" }.tap() // find button based on button.acceccibilityIdentifier
    * app.descendants(type:.button) { $0.label == "play" }.tap() // find button based on button.title
    * - Fixme: ⚠️️ make this method for children too
    */
   private func descendants(type: XCUIElement.ElementType = .any, condition: ElementParser.MatchCondition) -> [XCUIElement] {
      return ElementParser.descendants(element: self, condition: condition, type: type)
   }
   /**
    * Find first matching item in children based on condition (Only works for immediate chilren not grandchildren etc)
    * - Remark: Being able to do element?.firstDescendant(..) is powerfull when you need to chain calls. As you cant do that when you provide the elemnt as a parameter in the method call
    */
   private func firstChild(type: XCUIElement.ElementType = .any, _ condition: ElementParser.MatchCondition) -> XCUIElement? {
      return ElementParser.firstChild(element: self, condition: condition, type: type)
   }
   /**
    * Convenient for doing element.firstChild { $0.identifier = "someBtn" }
    */
   private func firstChild(_ condition: ElementParser.MatchCondition) -> XCUIElement? {
      return self.firstChild(type: .any, condition)
   }
}
