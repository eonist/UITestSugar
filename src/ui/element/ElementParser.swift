import Foundation
import XCTest
/**
 * Parser
 */
public class ElementParser {
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
   /**
    * Helps identify elements (Useful when there is localization involved)
    * ## Examples:
    * debugChildren(query: app.scrollViews.otherElements.buttons)
    * - Note: to debug descendants use the descendants call in the query
    */
   public static func debug(query: XCUIElementQuery) {
      let elements: [XCUIElement] = query.allElementsBoundByIndex
      elements.forEach { debug(element: $0) }
   }
   /**
    * Helps debug an element
    */
   public static func debug(element: XCUIElement, indentation: String = "") {
      Swift.print("\(indentation)identifier:  \(element.identifier) accessibilityLabel:  \(String(describing: element.accessibilityLabel)) label:  \(element.label) type:  \(element.elementType.string) title:  \(element.title)")
   }
   /**
    * Helps debug a hierarchy
    * ## Examples:
    * ElementParser.debugHierarchy(element: app, type: .any, indentaionLevel: 1)
    * - Remark: logs can get messy with UITesting, a way to see the hierarchy more clearly is to use the filter filed and filter for the "-" char
    */
   public static func debugHierarchy(element: XCUIElement, type: XCUIElement.ElementType = .any, indentationLevel: Int = 1) {
      let children = element.children(matching: type).allElementsBoundByIndex
      children.forEach {
         let indentationLevel: Int = indentationLevel + 1
         let identation: String = String(repeating: "-", count: indentationLevel)
         debug(element: $0, indentation: identation)
         debugHierarchy(element: $0, type: type, indentationLevel: indentationLevel) // keep traversing down the hierarchy
      }
   }
}
/**
 * Helps identify ElementType (some bug in apples code prevents this with regular String(describing:))
 */
extension XCUIElement.ElementType {
   enum ElementTypeName : String, CaseIterable {
      case any
      case other
      case application
      case group
      case window
      case sheet
      case drawer
      case alert
      case dialog
      case button
      case radioButton
      case radioGroup
      case checkBox
      case disclosureTriangle
      case popUpButton
      case comboBox
      case menuButton
      case toolbarButton
      case popover
      case keyboard
      case key
      case navigationBar
      case tabBar
      case tabGroup
      case toolbar
      case statusBar
      case table
      case tableRow
      case tableColumn
      case outline
      case outlineRow
      case browser
      case collectionView
      case slider
      case pageIndicator
      case progressIndicator
      case activityIndicator
      case segmentedControl
      case picker
      case pickerWheel
      case `switch`
      case toggle
      case link
      case image
      case icon
      case searchField
      case scrollView
      case scrollBar
      case staticText
      case textField
      case secureTextField
      case datePicker
      case textView
      case menu
      case menuItem
      case menuBar
      case menuBarItem
      case map
      case webView
      case incrementArrow
      case decrementArrow
      case timeline
      case ratingIndicator
      case valueIndicator
      case splitGroup
      case splitter
      case relevanceIndicator
      case colorWell
      case helpTag
      case matte
      case dockItem
      case ruler
      case rulerMarker
      case grid
      case levelIndicator
      case cell
      case layoutArea
      case layoutItem
      case handle
      case stepper
      case tab
      case touchBar
      case statusItem
   }
}
extension XCUIElement.ElementType {
   /**
    * XCUIElement.ElementType.button.string // button
    */
   public var string: String {
      return ElementTypeName.allCases[Int(self.rawValue)].rawValue
   }
}
