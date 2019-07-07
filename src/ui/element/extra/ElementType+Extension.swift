import Foundation
import XCTest

extension XCUIElement.ElementType {
   /**
    * Helps identify ElementType (some bug in apples code prevents this with regular String(describing:))
    */
   enum ElementTypeName: String, CaseIterable {
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
    * Returns a human readable representation of what kind of elementType the element is
    * ## Examples:
    * app.buttons.firstMatch.elementType.string // button
    */
   public var string: String {
      return ElementTypeName.allCases[Int(self.rawValue)].rawValue
   }
}
