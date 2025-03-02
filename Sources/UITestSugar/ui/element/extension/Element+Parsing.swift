#if canImport(XCTest)
import Foundation
import XCTest

extension XCUIElement {
   /**
    * `IDType` is a type alias for a tuple used to represent an element by its XCUIElementType and an optional identifier string.
    * - `type`: Specifies the XCUIElementType of the UI element.
    * - `id`: An optional string representing the unique identifier of the UI element.
    */
   public typealias IDType = (type: XCUIElementType, id: String?)

   /**
    * `LabelType` is a type alias for a tuple that represents an element type and an optional label string.
    * - `type`: Specifies the XCUIElementType of the UI element.
    * - `label`: An optional string representing the label associated with the UI element.
    */
   public typealias LabelType = (type: XCUIElementType, label: String?)
   /**
    * Retrieves an XCUIElement based on a hierarchical map of element types and identifiers or labels.
    * - Description: This method allows for a flexible search of UI elements by specifying a sequence of element types paired with identifiers or labels. It navigates through the UI hierarchy according to the provided sequence, returning the final element in the sequence.
    * - Remark: Supports a `SearchType` that can be either `type:id` or `type:label`, facilitating searches that can specify either an identifier or a label for each element in the hierarchy.
    * - Examples:
    *   ```
    *   let btn = app.firstDescendant([(type: XCUIElementType.any, id: "mainView"), (type: XCUIElementType.button, label: "actionButton")])
    *   btn.tap()
    *   ```
    * - Parameter map: An array of tuples where each tuple represents an element in the UI hierarchy by its type and an optional identifier or label.
    */
   public func firstDescendant(_ map: [Any]) -> XCUIElement {
      if map.count == 1, let query: Any = map.first { // if map is only 1 level deep
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
    * Retrieves the first descendant of the element that matches the specified query criteria.
    * - Description: This method searches for the first descendant of the current element based on the provided query. The query can be specified as either an `IDType` or a `LabelType`. Depending on the type of the query, different methods are invoked:
    *   - If the query is an `IDType`, the method `firstDescendant(type:id:)` is used to locate the descendant by its type and identifier.
    *   - If the query is a `LabelType`, the method `firstDescendant(label:type:)` is employed to find the descendant by its label and type.
    *   - If the query does not match either `IDType` or `LabelType`, a fatal error is triggered, indicating an unsupported query type.
    * - Parameter query: The criteria used to search for the descendant.
    * - Returns: The first descendant that matches the query, if found.
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
   /**
    * `SearchType` is a type alias for a tuple that represents an element type and an optional identifier string.
    * - `type`: Specifies the XCUIElementType of the UI element, determining the kind of UI component to search for.
    * - `id`: An optional string representing the unique identifier of the UI element, used to locate a specific instance of the element type.
    */   
   public typealias SearchType = (type: XCUIElement.ElementType, id: String?)
   /**
    * Returns the first descendant of the element that matches the specified query.
    * - Note: The query is represented as an array of `SearchType` tuples, where each tuple contains the type and ID or label of the UI element being searched for. This structure allows for precise targeting of elements within a complex UI hierarchy.
    * - Note: The function uses recursion to search for the element in a nested hierarchy of UI elements, traversing down the UI tree until the specified element is found or the hierarchy is fully explored.
    * - Parameter map: The query to use when searching for the descendant, structured as a sequence of `SearchType` tuples that define the path through the UI hierarchy.
    * - Returns: The first descendant of the element that matches the specified query, allowing for direct interaction with that UI element.
    */
   public func firstDescendant(_ map: [SearchType]) -> XCUIElement {
      if map.count == 1, let query: XCUIElement.SearchType = map.first { // if map is only 1 level deep
         return self.firstDescendant(type: query.type, id: query.id)
      } else if map.count > 1, let query: SearchType = map.first { // if map is more than 1 level deep
         let element: XCUIElement = self.firstDescendant(type: query.type, id: query.id)
         let newMap: [XCUIElement.SearchType] = Array(map[1..<map.count]) // substract first element
         return element.firstDescendant(newMap) // recursive call
      } else { // map is empty, might never be called
         Swift.print("🚫 map is an empty array 🚫")
         return self // the logic is that it will work with waiter calls
      }
   }
   /**
    * Constructs a query to find all descendants of the element that match the specified criteria.
    * - Description: This method generates an `XCUIElementQuery` that can be used to locate all descendants within the element's hierarchy that match the given criteria. The criteria are defined using an array of `SearchType` tuples, each specifying the type and optionally an ID or label of the UI element to be matched. The method recursively searches through nested hierarchies to find all matching descendants.
    * - Parameter map: An array of `SearchType` tuples that define the search criteria for the descendants. Each tuple includes a type of the UI element and an optional identifier or label.
    * - Returns: An `XCUIElementQuery` representing all descendants that match the specified criteria, allowing for further operations like assertions or interactions.
    */
   public func descendants(_ map: [SearchType]) -> XCUIElementQuery {
      if map.count == 1, let search: XCUIElement.SearchType = map.first { // if map is only 1 level deep
         return self.descendants(type: search.type, id: search.id)
      } else if map.count > 1, let search: SearchType = map.first { // if map is more than 1 level deep
         let element: XCUIElement = self.firstDescendant(type: search.type, id: search.id)
         let newMap: [XCUIElement.SearchType] = Array(map[1..<map.count])
         return element.descendants(newMap) // recursive call
      } else { // map is empty, might never be called
         Swift.print("🚫 map is an empty array 🚫")
         return self.otherElements // the logic is that it will work with waiter calls
      }
   }
   /**
    * Retrieves the first descendant of the element that matches the specified type and ID.
    * This method searches for the first descendant of the current element based on the provided type and ID. If the `id` is provided, it utilizes the `descendants(type:id:)` method to locate a descendant that matches both the type and the ID. If the `id` is `nil`, it instead uses the `descendants(matching:)` method to find any descendant of the specified type.
    * This method supports chaining with `waitToAppear` and `tap` methods, allowing for sequential operations such as waiting for the element to become visible and then interacting with it.
    * - Parameters:
    *   - type: The type of the UI element to search for.
    *   - id: The optional ID of the UI element to search for.
    * - Returns: The first descendant of the element that matches the specified criteria.
    * ## Examples:
    * app.firstDescendant(type: .button).waitToAppear(5)?.tap(wait: 2)
    * app.firstDescendant(id: "someBtn").waitToAppear(5)?.tap(wait: 2)
    * app.firstDescendant(type: .button, id: "someBtn").waitToAppear(5)?.tap(wait: 2)
    */
   public func firstDescendant(type: XCUIElement.ElementType = .any, id: String? = nil) -> XCUIElement {
      if let id: String = id { // If an ID is provided
         return self.descendants(type: type, id: id).firstMatch // Find the first descendant element with the specified type and ID
      } else { // If no ID is provided
         return self.descendants(matching: type).firstMatch // Find the first descendant element with the specified type
      }
   }
   /**
    * Constructs a query to locate all descendants of the element that match a specified type and optionally an ID, facilitating targeted searches within the UI hierarchy.
    * This method leverages the `descendants(matching:)` function to create a query for descendants of the specified type. If an ID is provided, the query is further refined to include only those descendants that also match the given ID, allowing for more precise element selection.
    * - Parameters:
    *   - type: The type of the UI element to search for, indicating the category of UI components to include in the query.
    *   - id: An optional identifier for the UI element. If provided, the query will only include elements that match this ID, narrowing the search to more specific elements.
    * - Returns: An `XCUIElementQuery` representing all descendants that match the specified type and, if provided, ID, enabling subsequent operations like assertions or interactions.
    */
   public func descendants(type: XCUIElement.ElementType = .any, id: String? = nil) -> XCUIElementQuery {
      if let id: String = id { // Check if the `id` parameter is not `nil`
         return self.descendants(matching: type).matching(identifier: id) // If so, find all descendants with the specified type and then filter the results to include only those with the specified ID
      } else { // If the `id` parameter is `nil`
         return self.descendants(matching: type) // Find all descendants with the specified type
      }
   }
   /**
    * Retrieves the first descendant of a specified type that matches a given label.
    * This method is useful for locating UI elements that are identified by visible text labels, particularly when multiple elements of the same type are present.
    * ## Examples:
    * app.firstDescendant(label: "Edit list", type: .button).tap(waitForExistence: 5)
    * - Parameters:
    *   - type: The type of the UI element to search for.
    *   - label: The text label of the UI element to locate.
    * - Returns: The first descendant of the element that matches the specified label and type.
    */
   public func firstDescendant(label: String?, type: XCUIElement.ElementType = .any) -> XCUIElement {
      if let lbl: String = label { // Check if the `label` parameter is not `nil`
         let query: XCUIElementQuery = self.descendants(matching: type) // Find all descendants with the specified type
         return QueryParser.firstElement(query, label: lbl) // If so, find the first element with the specified label
      } else { // If the `label` parameter is `nil`
         return self.descendants(matching: type).firstMatch // Find the first descendant with the specified type
      }
   }
   /**
    * Retrieves the first descendant of the specified type that matches a given title.
    * This method is particularly useful when you need to locate a UI element based on its title, which is often displayed as visible text. If a title is provided, the method searches all descendants of the specified type and filters them to find the first match with the given title. If no title is provided, it simply returns the first descendant of the specified type.
    * - Parameters:
    *   - title: The title of the UI element to locate. If nil, the search is only based on type.
    *   - type: The type of the UI element to search for.
    * - Returns: The first descendant that matches the specified title and type, or the first descendant of the type if no title is specified.
    */
   public func firstDescendant(title: String?, type: XCUIElement.ElementType = .any) -> XCUIElement {
      if let title: String = title { // Check if the `title` parameter is not `nil`
         let query: XCUIElementQuery = self.descendants(matching: type) // Find all descendants with the specified type
         return QueryParser.firstElement(query, title: title) // If so, find the first element with the specified title
      } else { // If the `title` parameter is `nil`
         return self.descendants(matching: type).firstMatch // Find the first descendant with the specified type
      }
   }
   /**
    * Retrieves the first descendant of the specified type that matches a given value.
    * This method is designed to locate a UI element within the descendants of the current element based on a specific value and type. If a value is provided, it filters the descendants of the specified type to find the first one that matches the given value. If no value is provided, it simply returns the first descendant of the specified type.
    * - Parameters:
    *   - value: The value used to identify the UI element. If nil, the search is based solely on the type.
    *   - type: The type of the UI element to search for.
    * - Returns: The first descendant that matches the specified value and type, or the first descendant of the type if no value is specified.
    */
   public func firstDescendant(value: String?, type: XCUIElement.ElementType = .any) -> XCUIElement {
      if let value: String = value { // Check if the `value` parameter is not `nil`
         let query: XCUIElementQuery = self.descendants(matching: type) // Find all descendants with the specified type
         return QueryParser.firstElement(query, value: value) // If so, find the first element with the specified value
      } else { // If the `value` parameter is `nil`
         return self.descendants(matching: type).firstMatch // Find the first descendant with the specified type
      }
   }
   /**
    * Searches for and returns the first element of a specified type that contains a sub-element satisfying a given condition.
    * This method is particularly useful for complex UI structures where elements are nested, and a specific condition needs to be met by one of the sub-elements.
    * - Remark: This method can be slow, especially with a broad search scope. To enhance performance, narrow down the search context before calling this method.
    * - Parameters:
    *   - type: The type of the UI element to search for.
    *   - condition: A closure that evaluates an `XCUIElement` and returns a `Bool`. This closure is applied to determine if a sub-element of the searched element meets the specified condition.
    * - Returns: The first element of the given type that contains a sub-element meeting the condition, or `nil` if no such element is found.
    * ## Example:
    * let cellWithSpecificContent = app.firstDescendant(type: .cell) {
    *    $0.elementType == .textField && $0.value == "data.json"
    * }
    */
   public func firstDescendant(type: XCUIElementType, condition: (XCUIElement) -> Bool) -> XCUIElement? {
      // Find all descendant elements with the specified type
      let descendants: XCUIElementQuery = self.descendants(matching: type)
      // Find the first element that has a descendant that satisfies the given condition
      let firstMatch: XCUIElement? = descendants.allElementsBoundByIndex.first {
         $0.firstDescendant(condition) != nil // Check if the descendant satisfies the given condition
      }
      return firstMatch // Return the first matching element, or nil if no match is found
   }
}
/**
 * Experimental
 */
extension XCUIElement {
   /**
    * Returns the first descendant element of the current element that matches the specified partial identifier and type.
    * This method is particularly useful for locating elements when only partial information about their identifiers is available, such as in applications developed with localized or dynamically generated IDs.
    * - Important: ⚠️️ This method employs the `CONTAINS` keyword in its predicate, which may result in matches with elements that have similar, but not identical, identifiers. This should be considered when using this method to ensure the accuracy of the element selection.
    * - Parameters:
    *   - partialId: The partial identifier used to locate the element.
    *   - type: The type of the element to search for. Defaults to `.any`, allowing any type of element to be matched.
    * - Returns: The first descendant element of the current element that matches the specified partial identifier and type.
    * ## Example:
    * ```
    * // Assuming the button has an identifier of `theBtn`
    * app.firstDescendant(partialId: "theBtn", type: .button).waitForExistence(timeout: 5) // returns true
    * app.firstDescendant(partialId: "heBt", type: .button).waitForExistence(timeout: 5) // returns true
    * app.firstDescendant(partialId: "theBtnX", type: .button).waitForExistence(timeout: 5) // returns false
    * ```
    */
   public func firstDescendant(partialId: String, type: XCUIElement.ElementType = .any) -> XCUIElement {
      let query: XCUIElementQuery = self.descendants(matching: type) // Get all descendants of the element that match the specified type
      let predicate: NSPredicate = .init(format: "identifier CONTAINS %@", partialId) // Create a predicate to filter the results by the specified identifier // Create a predicate that matches elements with an identifier that contains the specified partial ID
      let elementQuery: XCUIElementQuery = query.matching(predicate) // Find all descendants that match the predicate
      return elementQuery.firstMatch // Return the first descendant that matches the predicate
   }
}
/**
 * Parser (Children)
 */
extension XCUIElement {
   /**
    * Retrieves the first child element that matches the specified type and ID.
    * This method searches for child elements based on the provided type and ID. If the `id` parameter is provided (not `nil`), it utilizes the `children(id:type:)` method to locate all matching children and returns the first one found. If the `id` parameter is `nil`, it instead uses the `children(matching:)` method to simply find the first child of the specified type.
    * - Parameters:
    *   - type: The type of the UI element to search for.
    *   - id: The identifier of the UI element to search for, if any.
    * - Returns: The first child element that matches the given type and ID, or `nil` if no such element exists.
    */
   public func firstChild(type: XCUIElement.ElementType = .any, id: String? = nil) -> XCUIElement {
      if let id: String = id { // Check if the `id` parameter is not `nil`
         return self.children(id: id, type: type).firstMatch // If so, find all children with the specified type and ID and return the first match
      } else { // If the `id` parameter is `nil`
         return self.children(matching: type).firstMatch // This line of code is incomplete and will cause a compilation error
      }
   }
   /**
    * Retrieves all child elements that match a specific identifier and type from the current element.
    * This method filters the children of the current element to find those that match both the specified identifier and type. It is useful for scenarios where precise control over the selection of child elements is needed based on their accessibility identifiers.
    * - Parameters:
    *   - id: The accessibility identifier of the UI element being searched for.
    *   - type: The type of UI element being searched for, such as button, label, etc.
    * - Returns: An `XCUIElementQuery` object containing all matching child elements.
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
    * Searches through the descendants of the current element to find the first one that meets a specified condition. This method is useful for locating elements deep within the UI hierarchy, such as children or grandchildren.
    * - Remark: The ability to use `element?.firstDescendant(..)` facilitates method chaining, which is not possible when passing the element as a parameter.
    * - Description: This method iterates over the descendants of the current element, evaluating each against a provided condition. The search includes all nested levels of children, making it comprehensive.
    * - Parameters:
    *   - type: The type of UI element to search for. Defaults to `.any`, allowing any element type.
    *   - condition: A closure that evaluates an `XCUIElement` and returns a `Bool` indicating whether the element satisfies the specified condition.
    * - Returns: The first descendant that matches the condition, or `nil` if no matching element is found.
    * ## Example:
    * // Find the first button with an identifier of "someBtn"
    * element.firstDescendant(type: .button) { $0.identifier == "someBtn" }
    */
   private func firstDescendant(type: XCUIElement.ElementType = .any, _ condition: ElementParser.MatchCondition) -> XCUIElement? {
      ElementParser.firstDescendant(
         element: self, // The element to search for descendants
         condition: condition, // The condition that must be met for a descendant to be included in the results
         type: type // The type of element to search for
      ) // Find the first matching item in descendants based on condition (Works on immediate children and grandchildren and so on)
   }
   /**
    * Searches through the descendants of the current element to locate the first one that satisfies a specific condition.
    * - Description: This method iterates over the descendants of the current element, evaluating each against a provided condition to find the first match. It is useful for locating elements deep within the UI hierarchy based on dynamic criteria.
    * - Parameters:
    *   - condition: A closure that evaluates an `XCUIElement` and returns a `Bool` indicating whether the element meets the specified condition.
    * - Returns: The first descendant that matches the condition, or `nil` if no such element is found.
    * ## Example:
    * // Find the first button with an identifier of "someBtn"
    * element.firstDescendant { $0.identifier == "someBtn" }
    */
   private func firstDescendant(_ condition: ElementParser.MatchCondition) -> XCUIElement? {
      // Get the first descendant element of the current element that matches the specified condition and type
      self.firstDescendant(type: .any, condition)
   }
   /**
    * Retrieves all descendants of the element that satisfy a given condition, filtered by type.
    * This method is useful for identifying and interacting with specific UI elements deep within the hierarchy based on dynamic criteria.
    * - Parameters:
    *   - type: The type of UI element to search for. Defaults to `.any`, which includes all types.
    *   - condition: A closure that evaluates an `XCUIElement` and returns a `Bool`. This closure determines whether a particular element meets the specified criteria.
    * - Returns: An array of `XCUIElement` objects that represent all descendants matching the specified condition and type.
    * ## Examples:
    * // Find and tap a button with a specific accessibility identifier
    * app.descendants(type: .button) { $0.identifier == "specialBtn" }.tap()
    * // Find and tap a button with a specific title
    * app.descendants(type: .button) { $0.label == "play" }.tap()
    */
   private func descendants(type: XCUIElement.ElementType = .any, condition: ElementParser.MatchCondition) -> [XCUIElement] {
      ElementParser.descendants(
         element: self, // The element to search for descendants
         condition: condition, // The condition that must be met for a descendant to be included in the results
         type: type // The type of element to search for
      ) // Find all descendants of the element that match the specified condition
   }
   /**
    * Searches for and returns the first child element that meets a specified condition. This method only evaluates immediate children of the current element, not deeper descendants.
    * - Remark: Using `element?.firstDescendant(..)` is beneficial for chaining method calls, which is not possible when passing the element as a parameter.
    * - Description: This method iterates through the immediate children of the current element, checking each against the provided condition. It returns the first child that satisfies the condition.
    * - Parameters:
    *   - type: The type of UI element to search for, with a default of `.any`, which includes all types.
    *   - condition: A closure that evaluates an `XCUIElement` and returns a `Bool` indicating whether the element meets the specified condition.
    * - Returns: The first child element that matches the condition, or `nil` if no such child is found.
    * ## Example:
    * // Find the first button with an identifier of "someBtn"
    * element.firstChild(type: .button) { $0.identifier == "someBtn" }
    */
   private func firstChild(type: XCUIElement.ElementType = .any, _ condition: ElementParser.MatchCondition) -> XCUIElement? {
      // Get the first child element of the current element that matches the specified condition and type
      ElementParser.firstChild(
         element: self, // The element to search for the first child of
         condition: condition, // The condition that must be met for a child to be included in the results
         type: type // The type of element to search for
      )
   }
   /**
    * Returns the first child element of the current element that matches the specified condition.
    * This method simplifies the process of finding a child element by its identifier. It is a shorthand for `firstChild(type: .any, condition)` where the condition typically checks the `identifier` property of the child element.
    * - Description: Use this method to quickly find a child element based on its identifier without specifying the element type. This is particularly useful when the type of the element is unknown or irrelevant.
    * ## Examples:
    * // Example of finding a child element by its identifier
    * let button = element.firstChild { $0.identifier == "confirmButton" }
    * - Parameter condition: A closure that evaluates an `XCUIElement` and returns a `Bool` indicating whether the element meets the specified condition, typically related to the `identifier` property.
    * - Returns: The first child element of the current element that matches the specified condition, or `nil` if no such child is found.
    */
   private func firstChild(_ condition: ElementParser.MatchCondition) -> XCUIElement? {
      self.firstChild(
         type: .any, // The type of element to search for
         condition // The condition that must be met for a child to be included in the results
      )
   }
}
// deprecated ⚠️️
//extension XCUIElement {
//   // deprecated ⚠️️
//   @available(*, deprecated, renamed: "firstDescendant")
//   public func descendant(_ map: [SearchType]) -> XCUIElement {
//      firstDescendant(map) // Find the first descendant that matches the specified search types
//   }
//}
#endif
