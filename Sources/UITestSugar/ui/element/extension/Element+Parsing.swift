#if canImport(XCTest)
import Foundation
import XCTest

extension XCUIElement {
   public typealias IDType = (type: XCUIElementType, id: String?)
   public typealias LabelType = (type: XCUIElementType, label: String?)
   /**
    * Returns an XCUIElement for map
    * - Remark: Adds support for a `SearchType` that can be `type:id` or `type:label`
    * ## Examples
    * let btn = app.firstDescendant([(type: XCUIElementType.any, id: "mainView"), (type: XCUIElementType.button, label: "actionButton")])
    * btn.tap()
    * - Parameter map: - Fixme: ⚠️️
    */
   public func firstDescendant(_ map: [Any]) -> XCUIElement {
      if map.count == 1, let query = map.first { // if map is only 1 level deep
         return self.firstDescendant(query: query)
      } else if map.count > 1, let query: Any = map.first { // if map is more than 1 level deep
         let element: XCUIElement = self.firstDescendant(query: query)
         let newMap: [Any] = Array(map[1..<map.count]) // substract first element
         return element.firstDescendant(newMap) // recursive call
      } else { // map is empty, might never be called
         Swift.print("🚫 map is an empty array 🚫")
         return self // the logic is that it will work with waiter calls
      }
   }
   /**
    * Returns the first descendant of the element that matches the specified query.
    * The query parameter can be either an `IDType` or a `LabelType`.
    * If the query is an `IDType`, the function calls the `firstDescendant(type:id:)` method to find the first descendant with the specified type and ID.
    * If the query is a `LabelType`, the function calls the `firstDescendant(label:type:)` method to find the first descendant with the specified label and type.
    * If the query is neither an `IDType` nor a `LabelType`, the function raises a fatal error.
    * - Parameter query: The query to use when searching for the descendant.
    * - Returns: The first descendant of the element that matches the specified query.
    */
   private func firstDescendant(query: Any) -> XCUIElement {
      if let idQuery: IDType = query as? IDType { // Check if the query is an IDType
         return self.firstDescendant(type: idQuery.type, id: idQuery.id) // If so, call firstDescendant with type and ID
      } else if let labelQuery: LabelType = query as? LabelType { // Check if the query is a LabelType
         return self.firstDescendant(label: labelQuery.label, type: labelQuery.type) // If so, call firstDescendant with label and type
      } else { // If the query is neither an IDType nor a LabelType
         fatalError("⚠️️ Unsupported query type: \(query)") // Raise a fatal error
      }
   }
}
/**
 * Parser (Descendant)
 */
extension XCUIElement {
   public typealias SearchType = (type: XCUIElement.ElementType, id: String?)
   /**
    * Returns the first descendant of the element that matches the specified query.
    * The query is represented as an array of `SearchType` tuples, where each tuple contains the type and ID or label of the UI element being searched for.
    * The function uses recursion to search for the element in a nested hierarchy of UI elements.
    * - Parameter map: The query to use when searching for the descendant.
    * - Returns: The first descendant of the element that matches the specified query.
    */
   public func firstDescendant(_ map: [SearchType]) -> XCUIElement {
      if map.count == 1, let query = map.first { // if map is only 1 level deep
         return self.firstDescendant(type: query.type, id: query.id)
      } else if map.count > 1, let query: SearchType = map.first { // if map is more than 1 level deep
         let element = self.firstDescendant(type: query.type, id: query.id)
         let newMap = Array(map[1..<map.count]) // substract first element
         return element.firstDescendant(newMap) // recursive call
      } else { // map is empty, might never be called
         Swift.print("🚫 map is an empty array 🚫")
         return self // the logic is that it will work with waiter calls
      }
   }
   /**
    * Returns a query for all descendants of the element that match the specified query.
    * The query is represented as an array of `SearchType` tuples, where each tuple contains the type and ID or label of the UI element being searched for.
    * The function uses recursion to search for the element in a nested hierarchy of UI elements.
    * - Parameter map: The query to use when searching for the descendants.
    * - Returns: A query for all descendants of the element that match the specified query.
    */
   public func descendants(_ map: [SearchType]) -> XCUIElementQuery {
      if map.count == 1, let search = map.first { // if map is only 1 level deep
         return self.descendants(type: search.type, id: search.id)
      } else if map.count > 1, let search: SearchType = map.first { // if map is more than 1 level deep
         let element = self.firstDescendant(type: search.type, id: search.id)
         let newMap = Array(map[1..<map.count])
         return element.descendants(newMap) // recursive call
      } else { // map is empty, might never be called
         Swift.print("🚫 map is an empty array 🚫")
         return self.otherElements // the logic is that it will work with waiter calls
      }
   }
   /**
   * Returns the first descendant of the element that matches the specified type and ID.
   * If the `id` parameter is not `nil`, the function calls the `descendants(type:id:)` method to find the first descendant with the specified type and ID.
   * If the `id` parameter is `nil`, the function calls the `descendants(matching:)` method to find the first descendant with the specified type.
   * The function can be chained with the `waitToAppear` and `tap` methods to wait for the element to appear and then tap it.
   * - Parameter type: The type of UI element being searched for.
   * - Parameter id: The ID of the UI element being searched for.
   * - Returns: The first descendant of the element that matches the specified type and ID.
   * ## Examples:
   * app.firstDescendant(type: .button).waitToAppear(5)?.tap(wait: 2)
   * app.firstDescendant(id: "someBtn").waitToAppear(5)?.tap(wait: 2)
   * app.firstDescendant(type: .button, id: "someBtn").waitToAppear(5)?.tap(wait: 2)
   */
   public func firstDescendant(type: XCUIElement.ElementType = .any, id: String? = nil) -> XCUIElement {
      if let id = id {
         return self.descendants(type: type, id: id).firstMatch
      } else {
         return self.descendants(matching: type).firstMatch
      }
   }
   /**
    * Returns a query for all descendants of the element that match the specified type and ID.
    * If the `id` parameter is not `nil`, the function calls the `descendants(matching:)` method to find all descendants with the specified type and then filters the results to include only those with the specified ID.
    * If the `id` parameter is `nil`, the function calls the `descendants(matching:)` method to find all descendants with the specified type.
    * - Parameter type: The type of UI element being searched for.
    * - Parameter id: The ID of the UI element being searched for.
    * - Returns: A query for all descendants of the element that match the specified type and ID.
    */
   public func descendants(type: XCUIElement.ElementType = .any, id: String? = nil) -> XCUIElementQuery {
      if let id = id { // Check if the `id` parameter is not `nil`
         return self.descendants(matching: type).matching(identifier: id) // If so, find all descendants with the specified type and then filter the results to include only those with the specified ID
      } else { // If the `id` parameter is `nil`
         return self.descendants(matching: type) // Find all descendants with the specified type
      }
   }
   /**
    * Find first descendant of type that has a label (⚠️️ New ⚠️️)
    * ## Examples:
    * app.firstDescendant(label: "Edit list", type: .button).tap(waitForExistance: 5)
    * - Parameters:
    *   - type: The type to target
    *   - label: label to search for
    */
   public func firstDescendant(label: String?, type: XCUIElement.ElementType = .any) -> XCUIElement {
      if let lbl: String = label { // Check if the `label` parameter is not `nil`
         let query = self.descendants(matching: type) // Find all descendants with the specified type
         return QueryParser.firstElement(query, label: lbl) // If so, find the first element with the specified label
      } else { // If the `label` parameter is `nil`
         return self.descendants(matching: type).firstMatch // Find the first descendant with the specified type
      }
   }
   /**
    * Returns the first descendant of the element that matches the specified title and type.
    * If the `title` parameter is not `nil`, the function calls the `descendants(matching:)` method to find all descendants with the specified type and then filters the results to include only those with the specified title.
    * If the `title` parameter is `nil`, the function calls the `descendants(matching:)` method to find the first descendant with the specified type.
    * - Parameter title: The title of the UI element being searched for.
    * - Parameter type: The type of UI element being searched for.
    * - Returns: The first descendant of the element that matches the specified title and type.
    */
   public func firstDescendant(title: String?, type: XCUIElement.ElementType = .any) -> XCUIElement {
      if let title = title { // Check if the `title` parameter is not `nil`
         let query = self.descendants(matching: type) // Find all descendants with the specified type
         return QueryParser.firstElement(query, title: title) // If so, find the first element with the specified title
      } else { // If the `title` parameter is `nil`
         return self.descendants(matching: type).firstMatch // Find the first descendant with the specified type
      }
   }
   /**
    * Returns the first descendant of the element that matches the specified value and type.
    * If the `value` parameter is not `nil`, the function calls the `descendants(matching:)` method to find all descendants with the specified type and then filters the results to include only those with the specified value.
    * If the `value` parameter is `nil`, the function calls the `descendants(matching:)` method to find the first descendant with the specified type.
    * - Parameter value: The value of the UI element being searched for.
    * - Parameter type: The type of UI element being searched for.
    * - Returns: The first descendant of the element that matches the specified value and type.
    */
   public func firstDescendant(value: String?, type: XCUIElement.ElementType = .any) -> XCUIElement {
      if let value = value { // Check if the `value` parameter is not `nil`
         let query = self.descendants(matching: type) // Find all descendants with the specified type
         return QueryParser.firstElement(query, value: value) // If so, find the first element with the specified value
      } else { // If the `value` parameter is `nil`
         return self.descendants(matching: type).firstMatch // Find the first descendant with the specified type
      }
   }
   /**
    * Finds the first element of the specified type that has a sub-element that matches the provided condition.
    * - Remark: This method can be a bit slow, to speed it up, try to narrow down the element it is called on.
    * - Parameter type: The type of UI element being searched for.
    * - Parameter condition: A closure that takes an `XCUIElement` and returns a `Bool`. The closure is used to check if a sub-element of the element being searched has a certain condition.
    * - Returns: The first element of the specified type that has a sub-element that matches the provided condition.
    * ## Example:
    * app.firstDescendant(type: .cell) {
    *    $0.elementType == .textField && $0.value == "data.json"
    * }
    */
   public func firstDescendant(type: XCUIElementType, condition: (XCUIElement) -> Bool) -> XCUIElement? {
      self.descendants(matching: type).allElementsBoundByIndex.first {
         $0.firstDescendant(condition) != nil
      }
   }
}
/**
 * Experimental
 */
extension XCUIElement {
   /**
    * Returns the first descendant element of the current element that matches the specified partial identifier and type.
    * This method is useful for finding elements with identifiers that you only have partial information about, such as when the app was developed with localized IDs.
    * - Important: ⚠️️ This method uses `CONTAINS` in the predicate, which may match elements with similar but not identical identifiers.
    * - Parameters:
    *   - partialId: The partial identifier to search for.
    *   - type: The type of element to search for. Defaults to `.any`.
    * - Returns: The first descendant element of the current element that matches the specified partial identifier and type.
    * ## Example:
    * ```
    * // The button has an id of `theBtn`
    * app.firstDescendant(partialId: "theBtn", type: .button).waitForExistence(timeout: 5) // true
    * app.firstDescendant(partialId: "heBt", type: .button).waitForExistence(timeout: 5) // true
    * app.firstDescendant(partialId: "theBtnX", type: .button).waitForExistence(timeout: 5) // false
    * ```
    */
   public func firstDescendant(partialId: String, type: XCUIElement.ElementType = .any) -> XCUIElement {
      let query = self.descendants(matching: type)
      let predicate = NSPredicate(format: "identifier CONTAINS %@", partialId) // Create a predicate that matches elements with an identifier that contains the specified partial ID
      let elementQuery: XCUIElementQuery = query.matching(predicate) // Find all descendants that match the predicate
      return elementQuery.firstMatch // Return the first descendant that matches the predicate
   }
}
/**
 * Parser (Children)
 */
extension XCUIElement {
   /**
    * Returns the first child of the element that matches the specified type and ID.
    * If the `id` parameter is not `nil`, the function calls the `children(id:type:)` method to find all children with the specified type and ID and then returns the first match.
    * If the `id` parameter is `nil`, the function calls the `children(matching:)` method to find the first child with the specified type.
    * - Parameter type: The type of UI element being searched for.
    * - Parameter id: The ID of the UI element being searched for.
    * - Returns: The first child of the element that matches the specified type and ID.
    */
   public func firstChild(type: XCUIElement.ElementType = .any, id: String? = nil) -> XCUIElement {
      if let id = id { // Check if the `id` parameter is not `nil`
         return self.children(id: id, type: type).firstMatch // If so, find all children with the specified type and ID and return the first match
      } else { // If the `id` parameter is `nil`
         return self.children(matching: type).firstMatch // This line of code is incomplete and will cause a compilation error
      }
   }
   /**
    * Returns all children of the element that match the specified ID and type.
    * - Parameters:
    *   - id: The ID of the UI element being searched for.
    *   - type: The type of UI element being searched for.
    * - Returns: An `XCUIElementQuery` object containing all children of the element that match the specified ID and type.
    */
   public func children(id: String, type: XCUIElement.ElementType = .any) -> XCUIElementQuery {
      self.children(matching: type) // Find all children with the specified type
         .matching(identifier: id) // Filter the results to include only those with the specified ID
   }
}
/**
 * Beta (⚠️️ These won't work with waiter calls, but can be good for syncronouse exist calls ⚠️️)
 */
extension XCUIElement {
   /**
    * Finds the first matching item in descendants based on condition (Works on immediate children and grandchildren and so on).
    * - Remark: Being able to do `element?.firstDescendant(..)` is powerful when you need to chain calls. As you can't do that when you provide the element as a parameter in the method call.
    * - Parameters:
    *   - type: The type of UI element being searched for. Default is `.any`.
    *   - condition: A closure that takes an `XCUIElement` and returns a `Bool`. The closure is used to check if an element being searched has a certain condition.
    * - Returns: The first matching item in descendants based on condition.
    * ## Example:
    * // Find the first button with an identifier of "someBtn"
    * element.firstDescendant(type: .button) { $0.identifier == "someBtn" }
    */
   private func firstDescendant(type: XCUIElement.ElementType = .any, _ condition: ElementParser.MatchCondition) -> XCUIElement? {
      ElementParser.firstDescendant(element: self, condition: condition, type: type) // Find the first matching item in descendants based on condition (Works on immediate children and grandchildren and so on)
   }
   /**
    * Finds the first matching item in descendants based on condition.
    * - Parameters:
    *   - condition: A closure that takes an `XCUIElement` and returns a `Bool`. The closure is used to check if an element being searched has a certain condition.
    * - Returns: The first matching item in descendants based on condition.
    * ## Example:
    * // Find the first button with an identifier of "someBtn"
    * element.firstDescendant { $0.identifier == "someBtn" }
    */
   private func firstDescendant(_ condition: ElementParser.MatchCondition) -> XCUIElement? {
      // Get the first descendant element of the current element that matches the specified condition and type
      self.firstDescendant(type: .any, condition)
   }
   /**
    * Finds all descendants of the element that match the specified condition.
    * - Parameters:
    *   - type: The type of UI element being searched for. Default is `.any`.
    *   - condition: A closure that takes an `XCUIElement` and returns a `Bool`. The closure is used to check if an element being searched has a certain condition.
    * - Returns: An array of `XCUIElement` objects containing all descendants of the element that match the specified condition.
    * ## Examples:
    * app.descendants(type:.button) { $0.identifier == "specialBtn" }.tap() // find button based on button.acceccibilityIdentifier
    * app.descendants(type:.button) { $0.label == "play" }.tap() // find button based on button.title
    */
   private func descendants(type: XCUIElement.ElementType = .any, condition: ElementParser.MatchCondition) -> [XCUIElement] {
      ElementParser.descendants(element: self, condition: condition, type: type) // Find all descendants of the element that match the specified condition
   }
   /**
    * Finds the first matching item in children based on condition (Only works for immediate children not grandchildren etc).
    * - Remark: Being able to do `element?.firstDescendant(..)` is powerful when you need to chain calls. As you can't do that when you provide the element as a parameter in the method call.
    * - Parameters:
    *   - type: The type of UI element being searched for. Default is `.any`.
    *   - condition: A closure that takes an `XCUIElement` and returns a `Bool`. The closure is used to check if an element being searched has a certain condition.
    * - Returns: The first matching item in children based on condition.
    * ## Example:
    * // Find the first button with an identifier of "someBtn"
    * element.firstChild(type: .button) { $0.identifier == "someBtn" }
    */
   private func firstChild(type: XCUIElement.ElementType = .any, _ condition: ElementParser.MatchCondition) -> XCUIElement? {
      // Get the first child element of the current element that matches the specified condition and type
      ElementParser.firstChild(element: self, condition: condition, type: type)
   }
   /**
    * Returns the first child element of the current element that matches the specified condition and type.
    * This method is a convenient shorthand for calling `firstChild(type: .any, condition)` with a closure that sets the `identifier` property of the child element.
    * ## Examples:
    * Convenient for doing `element.firstChild { $0.identifier = "someBtn" }`
    * - Parameter condition: A closure that sets the `identifier` property of the child element.
    * - Returns: The first child element of the current element that matches the specified condition and type.
    */
   private func firstChild(_ condition: ElementParser.MatchCondition) -> XCUIElement? {
      self.firstChild(type: .any, condition)
   }
}
// deprecated ⚠️️
extension XCUIElement {
   // deprecated ⚠️️
   @available(*, deprecated, renamed: "firstDescendant")
   public func descendant(_ map: [SearchType]) -> XCUIElement {
      firstDescendant(map) // Find the first descendant that matches the specified search types
   }
}
#endif
