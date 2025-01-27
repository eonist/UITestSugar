#if canImport(XCTest)
import Foundation
import XCTest
/**
 * Hierarchy parser
 */
extension ElementParser {
   /**
    * Returns an array of ancestral elements for a specified element, tracing back from a given root.
    * - Description: This method recursively searches the ancestors of the specified element starting from the provided root. It collects all ancestors until it finds the first element that satisfies the specified condition. The result is an array of tuples, each containing the index and the element itself, tracing the path from the root to the element that meets the condition.
    * - Remark: If no element satisfies the condition, this function returns nil, indicating that no suitable ancestor was found.
    * - Fixme: ⚠️️ Refactor with `.map` or `.flatMap` on this method when u have time
    * - Fixme: ⚠️️ You can also use `elementAtIndex` and `element.count`
    * - Parameters:
    *   - root: The starting point for the search, represented as a tuple containing an index and an element.
    *   - condition: A closure that evaluates each element to determine if it meets the desired criteria.
    * ## Example:
    * let app = XCUIApplication()
    * let condition: ElementParser.MatchCondition = { element in
    *     let size = element.screenshot().image.size
    *     Swift.print("Size: \(size)")
    *     return size.width > 100 && size.height > 100 // Example condition based on size
    * }
    * let ancestry: [(Int, XCUIElement)]? = ElementParser.ancestry(root: (0, app), condition: condition)
    * if let ancestry = ancestry {
    *     let imgElementParent = ancestry.last
    *     let indices: [Int] = ancestry.map { $0.0 }
    *     let elements: [XCUIElement] = ancestry.map { $0.1 }
    *     let descendant: XCUIElement? = ElementParser.element(root: app, index: indices)
    *     // Further processing or assertions can be done here
    * }
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
         else if let descendants: [(Int, XCUIElement)] = ancestry(root: (0, child), condition: condition) {
            collector = [(i, child)] + descendants
            break
         }
      }
      return collector
   }
   // Suggested by o1:
   // - Fixme: ⚠️️ add doc
   public static func ancestry2(root: (index: Int, element: XCUIElement), condition: MatchCondition) -> [(Int, XCUIElement)]? {
      if condition(root.element) {
         return [root]
      }
      let children = root.element.children(matching: .any).allElementsBoundByIndex
      for (index, child) in children.enumerated() {
         if let result = ancestry(root: (index, child), condition: condition) {
               return [root] + result
         }
      }
      return nil
   }
   /**
    * Retrieves an element from a hierarchical structure based on a specified index path.
    * - Description: This method navigates through the hierarchy of the specified root element to locate and return an element at a given index path. The index path is an array of integers where each integer represents the child index at that level of the hierarchy.
    * - Remark: If the index path is empty, the root element itself is returned.
    * - Remark: If the index path reaches its final value, the search terminates and returns the element at that final index.
    * - Remark: For non-terminal values in the index path, the method recursively continues the search from the child element at the current index.
    * - Fixme: ⚠️️ Consider optimizing by using a query-based approach for faster element retrieval.
    * - Fixme: ⚠️️ Utilize `elementAtIndex` and `element.count` to enhance performance and readability.
    * - Parameters:
    *   - root: The root element from which the search begins.
    *   - index: An array of integers representing the hierarchical path to the desired element.
    * ## Example:
    * let app = XCUIApplication()
    * let targetElement = ElementParser.element(root: app, index: [0, 1, 2])
    */
   public static func element(root: XCUIElement, index: [Int]) -> XCUIElement? {
      let children: [XCUIElement] = root.children(matching: .any).allElementsBoundByIndex
      if index.isEmpty { // If the index is empty, 
         return root // return the root element
      }
      // If the index is at its end point, cut off the branch and return the element at the specified index
      else if index.count == 1 && index[0] < children.count {
         return children[index[0]]
      }
      // If the index is not at its end point, recursively call the element function on the child element at the specified index
      else if index.count > 1 && !children.isEmpty && index[0] < children.count {
         // Create a new index array that excludes the first index
         let newIndex: [Int] = Array(index[1..<index.count])
         // Get the child element at the specified index
         let child: XCUIElement = children[index[0]]
         // Recursively call the element function on the child element with the new index array
         return element(root: child, index: newIndex)
      }
      // If the element at the specified index doesn't exist, return nil
      return nil
   }
   /**
    * Returns an array of ancestral elements for a specified element, tracing the path from the root to the target element.
    * - Description: This method navigates up the hierarchy from a specified element, identified by an index path, to the root element. It collects all ancestral elements along the path, providing a clear trace of the hierarchy leading to the target element.
    * - Parameters:
    *   - root: The root element from which the search begins.
    *   - index: An array of integers representing the hierarchical path to the target element.
    * - Remark: This function performs a recursive search through the hierarchy based on the provided index path. If the index path is valid, it returns an array of all ancestral elements from the target element up to the root. If the index path is empty or invalid, it returns an empty array.
    * - Remark: This method is particularly useful for debugging purposes or when a clear understanding of the element hierarchy is required.
    * ## Example:
    * let app = XCUIApplication()
    * let pathToElement = [0, 1, 2]
    * let ancestry: [XCUIElement?] = ElementParser.ancestry(root: app, index: pathToElement)
    * let debugAncestry: String = ElementDebugger.debug(elements: ancestry.compactMap { $0 })
    * // debugAncestry contains a string representation of the ancestral elements
    */
   public static func ancestry(root: XCUIElement, index: [Int]) -> [XCUIElement?] {
      var index: [Int] = index // Store temp var
      var ancestry: [XCUIElement?] = []
      // Loop through the index array and add each ancestral element to the ancestry array
      while !index.isEmpty {
         // Get the element at the specified index
         let element: XCUIElement? = ElementParser.element(
            root: root, // The root element to search from
            index: index // The index of the element to retrieve
         )
         ancestry.append(element) // Add the element to the ancestry array
         _ = index.popLast() // Remove the last index from the index array
      }
      return ancestry.reversed() // Reverse the ancestry array and return it
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
