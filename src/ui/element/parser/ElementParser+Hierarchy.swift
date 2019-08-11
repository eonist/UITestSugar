import Foundation
import XCTest
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
      for (i, child) in children.enumerated() {
         let metCondition: Bool = condition(child)
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
    * - Fixme: Base it on query instead, because it's faster
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
    * Fixme: Since XCUIElement isn't comparable
    */
   public func parent(element: XCUIElement) {
      Swift.print("⚠️️ not in use yet ⚠️️")
   }
}
/**
 * Type for ancestry method
 */
extension ElementParser {
   public typealias MatchCondition = (_ element: XCUIElement) -> Bool
}

//let imgElement = XCUIApplication().descendants(matching: .image).firstMatch
//let condition: ElementParser.MatchCondition = { element in element.screenshot().image.size == CGSize(width: 200, height: 50)) }
//let ancestry: [XCUIElement]? = ElementParser.ancestry(element: imgElement, condition: condition)
//let ImgElementParent: XCUIElement? = ancestry?.last