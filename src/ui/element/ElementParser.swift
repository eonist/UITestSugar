import Foundation
import XCTest
/**
 * Parser
 */
public class ElementParser {
   /**
    * Find first matching item in children based on condition
    * ## Examples:
    * let viewAllButton: XCUIElement? = firstChild(element: app, condition: { $0.identifier == "View all" })
    */
   public static func firstChild(element: XCUIElement, condition: ElementParser.MatchCondition, type: XCUIElement.ElementType = .any) -> XCUIElement? {
      let children = ElementParser.children(element: element, type: type)
      return children.first { condition($0) }
   }
   /**
    * Find first matching item in descendants based on condition
    * ## Examples:
    * let viewAllButton: XCUIElement? = firstDescendant(element: app, condition: { $0.identifier == "View all" })
    */
   public static func firstDescendant(element: XCUIElement, condition: ElementParser.MatchCondition, type: XCUIElement.ElementType = .any) -> XCUIElement? {
      let descendants = ElementParser.descendants(element: element, type: type)
      return descendants.first { condition($0) }
   }
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
}
/**
 * Type
 */
extension ElementParser {
   public typealias MatchCondition = (_ element: XCUIElement) -> Bool
}
/**
 * Hierarchy parser
 */
extension ElementParser {
   
   /**
    * Returns an array of ancestral elements (alt name: heritage)
    * - Parameter condition: a closure that evaluates to true or false
    * - Parameter element: the point to search from
    * ## Example:
    * let condition: ElementParser.MatchCondition = { element in let s = element.screenshot().image.size; Swift.print("s:  \(s)"); return s == size/*element == btn*/} // .screenshot().image.size == size
    * let ancestry: [(Int, XCUIElement)]? = ElementParser.ancestry(root: (0, app), condition: condition)
    * let imgElementParent  = ancestry?.last
    * let index: [Int] = ancestry!.map { $0.0 }
    * let descendant: XCUIElement? = ElementParser.element(root: app, index: index)
    * - Fixme: ⚠️️ Refactor with .map or .flatMap on this method when u have time
    * - Fixme: ⚠️️ You can also use elementAtIndex and element.count
    */
   public static func ancestry(root: (index: Int, element: XCUIElement), condition: MatchCondition) -> [(Int, XCUIElement)]? {
      var collector: [(Int, XCUIElement)]?
      let children: [XCUIElement] = root.element.children(matching: .any).allElementsBoundByIndex
//      Swift.print("children.count:  \(children.count)")
      for (i, child) in children.enumerated() {
         let metCondition: Bool = condition(child)
//         Swift.print("metCondition:  \(metCondition)")
         if metCondition {
            collector = [(i, child)] // found the item, we don't include the actual item we are looking for
            break
         } else if let descendants = ancestry(root: (0, child), condition: condition) { // try to traverse the descendants
            collector = [(i, child)] + descendants
            break
         }
      }
      return collector
   }
   /**
    * Returns element in a hierarchy based on a mapIndex
    * - Fixme: Base it on query instead, because its faster
    * - Fixme: ⚠️️ You can also use elementAtIndex and element.count
    */
   public static func element(root: XCUIElement, index: [Int]) -> XCUIElement? {
      let children: [XCUIElement] = root.children(matching: .any).allElementsBoundByIndex
      if index.isEmpty { return root }/*returns the root*/
      else if index.count == 1 && children.count >= index[0] { return children[index[0]] }/* the index is at its end point, cut of the branch */
      else if index.count > 1 && !children.isEmpty {
         let newIndex = Array(index[1..<index.count])
         let child: XCUIElement = children[index[0]]
         return element(root: child, index: newIndex)
      } /* here is where the recursive magic happens */
      return nil
   }
   /**
    * Fixme: Since XCUIElement isnt comparable
    */
   public func parent(element: XCUIElement) {
      Swift.print("⚠️️ not in use yet ⚠️️")
   }
}

//let imgElement = XCUIApplication().descendants(matching: .image).firstMatch
//let condition: ElementParser.MatchCondition = { element in element.screenshot().image.size == CGSize(width: 200, height: 50)) }
//let ancestry: [XCUIElement]? = ElementParser.ancestry(element: imgElement, condition: condition)
//let ImgElementParent: XCUIElement? = ancestry?.last
