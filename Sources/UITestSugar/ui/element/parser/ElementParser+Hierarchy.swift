#if canImport(XCTest)
import Foundation
import XCTest
/**
 * Hierarchy parser
 */
extension ElementParser {
   /**
    * Returns an array of ancestral elements for a specified element.
    * - Fixme: ⚠️️ Refactor with `.map` or `.flatMap` on this method when u have time
    * - Fixme: ⚠️️ You can also use `elementAtIndex` and `element.count`
    * - Parameters:
    *   - root: The point to search from.
    *   - condition: A closure that evaluates to true or false.
    * - Remark: This function recursively searches the ancestors of the specified element to find the first element that satisfies the specified condition. It then returns an array of all ancestral elements from the specified element to the element that satisfies the condition.
    * - Remark: If no element satisfies the condition, this function returns nil.
    * ## Example:
    * let app = XCUIApplication()
    * let condition: ElementParser.MatchCondition = { element in let s = element.screenshot().image.size; Swift.print("s:  \(s)"); return s == size/*element == btn*/} // .screenshot().image.size == size
    * let ancestry: [(Int, XCUIElement)]? = ElementParser.ancestry(root: (0, app), condition: condition)
    * let imgElementParent  = ancestry?.last
    * let indices: [Int] = ancestry!.map { $0.0 }
    * let elements: [XCUIElement] = ancestry!.map { $0.1 }
    * let descendant: XCUIElement? = ElementParser.element(root: app, index: indices)
    */
   public static func ancestry(root: (index: Int, element: XCUIElement), condition: MatchCondition) -> [(Int, XCUIElement)]? {
      var collector: [(Int, XCUIElement)]?
      let children: [XCUIElement] = root.element.children(matching: .any).allElementsBoundByIndex
      // Loop through the children of the root element
      for (i, child) in children.enumerated() {
         let metCondition: Bool = condition(child)
         // If the child satisfies the condition, add it to the collector array and break the loop
         if metCondition {
            collector = [(i, child)] // Found the item, we don't include the actual item we are looking for
            break
         } 
         // If the child doesn't satisfy the condition, recursively call the ancestry function on the child
         // and add the child and its descendants to the collector array
         else if let descendants = ancestry(root: (0, child), condition: condition) {
            collector = [(i, child)] + descendants
            break
         }
      }
      return collector
   }
   /**
    * Returns an element in a hierarchy based on a `mapIndex`.
    * - Fixme: ⚠️️ Base it on query instead, because it's faster.
    * - Fixme: ⚠️️ You can also use `elementAtIndex` and `element.count`.
    * - Parameters:
    *   - root: The root element to search from.
    *   - index: An array of integers that represents the path to the desired element.
    * - Remark: This function recursively searches the hierarchy of the specified root element to find the element at the specified index. It returns the element if it exists, or nil if it doesn't.
    * - Remark: If the index is empty, this function returns the root element.
    * - Remark: If the index is at its end point, this function cuts off the branch and returns the element at the specified index.
    * - Remark: If the index is not at its end point, this function recursively calls itself on the child element at the specified index.
    * ## Example:
    * let app = XCUIApplication()
    * let element = ElementParser.element(root: app, index: [0, 1, 2])
    */
   public static func element(root: XCUIElement, index: [Int]) -> XCUIElement? {
      let children: [XCUIElement] = root.children(matching: .any).allElementsBoundByIndex
      // If the index is empty, return the root element
      if index.isEmpty { return root }
      // If the index is at its end point, cut off the branch and return the element at the specified index
      else if index.count == 1 && index[0] < children.count { return children[index[0]] }
      // If the index is not at its end point, recursively call the element function on the child element at the specified index
      else if index.count > 1 && !children.isEmpty && index[0] < children.count {
         // Create a new index array that excludes the first index
         let newIndex = Array(index[1..<index.count])
         // Get the child element at the specified index
         let child: XCUIElement = children[index[0]]
         // Recursively call the element function on the child element with the new index array
         return element(root: child, index: newIndex)
      }
      // If the element at the specified index doesn't exist, return nil
      return nil
   }
   /**
    * Returns an array of ancestral elements for a specified element.
    * - Parameters:
    *   - root: The root element to search from.
    *   - index: An array of integers that represents the path to the desired element.
    * - Remark: This function recursively searches the hierarchy of the specified root element to find the element at the specified index. It then returns an array of all ancestral elements from the specified element to the root element.
    * - Remark: If the index is empty, this function returns an empty array.
    * - Remark: If the index is not valid, this function returns an empty array.
    * ## Example:
    * let app = XCUIApplication()
    * let pathToElement = [0, 1, 2]
    * let ancestry: [XCUIElement?] = ElementParser.ancestry(root: app, index: pathToElement)
    * let debugAncestry: String = ElementDebugger.debug(elements: ancestry.compactMap { $0 })
    * // debugAncestry contains a string representation of the ancestral elements
    */
   public static func ancestry(root: XCUIElement, index: [Int]) -> [XCUIElement?] {
      var index = index
      var ancestry: [XCUIElement?] = []
      // Loop through the index array and add each ancestral element to the ancestry array
      while !index.isEmpty {
         // Get the element at the specified index
         let element = ElementParser.element(root: root, index: index)
         // Add the element to the ancestry array
         ancestry.append(element)
         // Remove the last index from the index array
         _ = index.popLast()
      }
      // Reverse the ancestry array and return it
      return ancestry.reversed()
   }
   /**
    * - Fixme: ⚠️️ Since `XCUIElement` isn't comparable
    * - Parameter element: - Fixme: ⚠️️
    */
   public func parent(element: XCUIElement) {
      Swift.print("⚠️️ not in use yet ⚠️️")
   }
}
/**
 * Type for ancestry method
 */
extension ElementParser {
   /**
    * A closure that takes an `XCUIElement` as input and returns a boolean value.
    * - Remark: This closure is used to define a custom condition for filtering elements in a hierarchy. It takes an `XCUIElement` as input and returns a boolean value that indicates whether the element satisfies the specified condition.
    * - Remark: When comparing `XCUIElement` instances, it's important to use a custom closure instead of the `==` or `isEqual` operators. This is because `XCUIElement` instances are compared based on their identity, not their attributes. Two `XCUIElement` instances that represent the same UI element may have different identities, which means that they won't be equal when compared using the `==` or `isEqual` operators. To compare `XCUIElement` instances based on their attributes, you need to define a custom closure that compares the attributes of the elements.
    * ## Example:
    * let condition: ElementParser.MatchCondition = { $0.label == "Button" }
    * let button = app.buttons.element(matching: .any, identifier: "buttonIdentifier")
    * let satisfiesCondition = condition(button)
    */
   public typealias MatchCondition = (_ element: XCUIElement) -> Bool
}
#endif
// let imgElement = XCUIApplication().descendants(matching: .image).firstMatch
// let condition: ElementParser.MatchCondition = { element in element.screenshot().image.size == CGSize(width: 200, height: 50)) }
// let ancestry: [XCUIElement]? = ElementParser.ancestry(element: imgElement, condition: condition)
// let ImgElementParent: XCUIElement? = ancestry?.last
