#if canImport(XCTest)
import Foundation
import XCTest

extension XCUIElement.ElementType {
   /**
    * Helps identify ElementType (some bug in apples code prevents this with regular String(describing:))
    * - Remark: ⚠️️ label is .staticText 🤷 -> because universal OS support etc, macOS doesnt have UILabel etc
    */
   enum ElementTypeName: String, CaseIterable {
      case any
      case other
      case application // The application case represents the main application element.
      case group // The group case represents a group of elements, such as a table or a collection view.
      case window // The window case represents a window element, such as a dialog or an alert.
      case sheet // The sheet case represents a sheet element, which is a modal dialog that is attached to a window.
      case drawer // The drawer case represents a drawer element, which is a panel that slides out from the side of a window.
      case alert // The alert case represents an alert element, which is a modal dialog that displays a message to the user and requires a response before continuing.
      case dialog // The dialog case represents a dialog element, which is a modal dialog that prompts the user for input or displays information.
      case button // The button case represents a button element, which is a control that the user can click to perform an action.
      case radioButton // The radioButton case represents a radio button element, which is a control that allows the user to select one option from a group of options.
      case radioGroup // The radioGroup case represents a group of radio buttons, which are a set of controls that allow the user to select one option from a group of options.
      case checkBox // The checkBox case represents a check box element, which is a control that allows the user to select or deselect an option.
      case disclosureTriangle // The disclosureTriangle case represents a disclosure triangle element, which is a control that allows the user to expand or collapse a section of content.
      case popUpButton // The popUpButton case represents a pop-up button element, which is a control that displays a list of options when clicked.
      case comboBox // The comboBox case represents a combo box element, which is a control that allows the user to select an option from a list or enter a custom value.
      case menuButton // This case represents a button that opens a menu of options. This type of button is often used in navigation bars or toolbars to provide access to additional functionality or settings.
      case toolbarButton // This case represents a button that appears in a toolbar. Toolbars are often used to provide quick access to commonly used actions or commands.
      case popover // This case represents a view that appears as a popover. Popovers are often used to display additional information or options in response to a user action, such as tapping a button or selecting a table row.
      case keyboard // This case represents the on-screen keyboard. The keyboard is used to allow users to enter text or other input into an app.
      case key // This case represents a key on the on-screen keyboard. Each key on the keyboard is represented by a separate key element.
      case navigationBar // This case represents the navigation bar at the top of a screen. The navigation bar is often used to display the title of the current screen, as well as buttons for navigating to other screens or performing other actions.
      case tabBar // This case represents the tab bar at the bottom of a screen. Tab bars are often used to provide access to different sections or modes of an app.
      case tabGroup // This case represents a group of tabs in a tab bar. Each tab in the group is represented by a separate tabGroup element.
      case toolbar // This case represents a toolbar at the bottom of a screen. Toolbars are often used to provide quick access to commonly used actions or commands.
      case statusBar // This case represents the status bar at the top of a screen. The status bar is used to display information about the current state of the device, such as the time, battery level, or cellular signal strength.
      case table // This case represents a table view, which is a scrollable list of rows that can be used to display large amounts of data in a structured format.
      case tableRow // This case represents a row in a table view. Each row in the table is represented by a separate tableRow element.
      case tableColumn // This case represents a column in a table view. Each column in the table is represented by a separate tableColumn element.
      case outline // This case represents an outline view, which is a hierarchical list of items that can be expanded or collapsed to show or hide additional detail.
      case outlineRow // This case represents a row in an outline view. Each row in the outline is represented by a separate outlineRow element.
      case browser // This case represents a browser view, which is a specialized type of outline view that is used to display hierarchical data in a way that resembles a file system.
      case collectionView // This case represents a collection view, which is a flexible and customizable grid-based layout that can be used to display a wide variety of content, such as images, text, or custom views.
      case slider // This case represents a slider control, which is a UI element that allows users to select a value from a range of values by dragging a thumb along a track.
      case pageIndicator // This case represents a page indicator, which is a UI element that is used to indicate the current page or position within a scrollable view, such as a collection view or scroll view.
      case progressIndicator // This case represents a progress indicator, which is a UI element that is used to show the progress of a task or operation.
      case activityIndicator // This case represents an activity indicator, which is a UI element that is used to indicate that a task or operation is in progress.
      case segmentedControl // This case represents a segmented control, which is a UI element that allows users to select from a set of mutually exclusive options.
      case picker // This case represents a picker view, which is a UI element that allows users to select from a set of values by spinning a wheel or scrolling through a list.
      case pickerWheel // This case represents a picker wheel, which is a UI element that is used to select a value from a set of values by spinning a wheel.
      case `switch` // This case represents a switch control, which is a UI element that allows users to toggle a setting or option on or off.
      case toggle // This case represents a toggle button, which is a UI element that allows users to toggle a setting or option on or off.
      case link // This case represents a link, which is a UI element that allows users to navigate to another location or screen within an app or on the web.
      case image // This case represents an image view, which is a UI element that displays an image.
      case icon // This case represents an icon view, which is a UI element that displays an icon.
      case searchField // searchField: This case represents a search field, which is a UI element that allows users to enter search terms and perform a search.
      case scrollView // Represents a scroll view element. A scroll view is a container that allows users to scroll through a large amount of content that would otherwise not fit on the screen. It is often used to display long lists or large images.
      case scrollBar // Represents a scroll bar element. A scroll bar is a graphical control element that allows users to scroll through content in a scrollable area, such as a scroll view. It typically appears as a thin bar on the side or bottom of the scrollable area.
      case staticText // Represents a static text element. A static text element is a piece of text that does not change. It is often used to display labels or instructions to the user.
      case textField // Represents a text field element. A text field is an input field that allows users to enter text. It is often used for things like usernames, passwords, or search queries.
      case secureTextField // Represents a secure text field element. A secure text field is a text field that obscures the text that the user enters, typically with asterisks or dots. It is often used for passwords or other sensitive information.
      case datePicker // Represents a date picker element. A date picker is a control that allows users to select a date or time. It typically appears as a wheel or a calendar.
      case textView // Represents a text view element. A text view is a container that allows users to enter and edit multiple lines of text. It is often used for things like comments or notes.
      case menu // Represents a menu element. A menu is a list of options that appears when the user clicks on a button or other control. It is often used to provide additional options or actions to the user.
      case menuItem // Represents a menu item element. A menu item is an individual option in a menu. It typically appears as a text label or an icon.
      case menuBar // Represents a menu bar element. A menu bar is a graphical control element that displays a list of menus. It is often used in desktop applications to provide access to various features or functions.
      case menuBarItem // Represents a menu bar item element. A menu bar item is an individual item in a menu bar. It typically appears as a text label or an icon.
      case map // map: Represents a map element. A map is a visual representation of geographic data, often used to display locations or directions.
      case webView // webView: Represents a web view element. A web view is a container that displays web content, such as a website or HTML document.
      case incrementArrow // incrementArrow: Represents an increment arrow element. An increment arrow is a graphical control element that allows users to increase a value, such as a number or a slider position.
      case decrementArrow // decrementArrow: Represents a decrement arrow element. A decrement arrow is a graphical control element that allows users to decrease a value, such as a number or a slider position.
      case timeline // Represents a timeline element. A timeline is a graphical representation of events over time, often used to display historical data or progress.
      case ratingIndicator // Represents a rating indicator element. A rating indicator is a graphical control element that allows users to rate something, such as a product or a review.
      case valueIndicator // Represents a value indicator element. A value indicator is a graphical control element that displays a value, such as a number or a percentage.
      case splitGroup // Represents a split group element. A split group is a container that allows users to resize two adjacent views, often used to display a master-detail interface.
      case splitter // Represents a splitter element. A splitter is a graphical control element that allows users to resize two adjacent views, often used in conjunction with a split group.
      case relevanceIndicator // Represents a relevance indicator element. A relevance indicator is a graphical control element that displays the relevance or importance of something, such as a search result or a recommendation.
      case colorWell // Represents a color well element. A color well is a graphical control element that allows users to select a color, often used in conjunction with a color picker.
      case helpTag // Represents a help tag element. A help tag is a graphical control element that displays contextual help or information when the user hovers over it.
      case matte // Represents a matte element. A matte is a container that provides a background or border for other UI elements, often used to group related elements together.
      case dockItem // Represents a dock item element. A dock item is an icon or label that appears in the dock of a macOS application, often used to provide quick access to frequently used features or functions.
      case ruler // Represents a ruler element. A ruler is a graphical control element that displays measurements, often used in conjunction with a drawing or layout tool.
      case rulerMarker // Represents a ruler marker element. A ruler marker is a graphical control element that indicates a specific measurement on a ruler, often used in conjunction with a drawing or layout tool.
      case grid // Represents a grid element. A grid is a graphical control element that displays a set of related data in a tabular format, often used to display data in a spreadsheet or table.
      case levelIndicator // Represents a level indicator element. A level indicator is a graphical control element that displays a value as a series of discrete levels, often used to display progress or status.
      case cell // Represents a cell element. A cell is a container that displays a single item of data in a grid or table, often used in conjunction with a data source.
      case layoutArea // Represents a layout area element. A layout area is a container that provides a visual representation of the layout of other UI elements, often used in conjunction with a layout tool.
      case layoutItem // Represents a layout item element. A layout item is a UI element that can be positioned and sized within a layout area, often used in conjunction with a layout tool.
      case handle // Represents a handle element. A handle is a graphical control element that allows users to resize or move a UI element, often used in conjunction with a layout tool.
      case stepper // Represents a stepper element. A stepper is a graphical control element that allows users to increase or decrease a value in small increments, often used in conjunction with a text field or slider.
      case tab // Represents a tab element. A tab is a graphical control element that allows users to switch between different views or sections of an application, often used in conjunction with a tab bar or tab view.
      case touchBar // Represents a touch bar element. A touch bar is a contextual toolbar that appears on the keyboard of a MacBook Pro with Touch Bar, often used to provide quick access to frequently used features or functions.
      case statusItem // Represents a status item element. A status item is an icon or label that appears in the status bar of a macOS application, often used to provide information or quick access to frequently used features or functions.
   }
}
extension XCUIElement.ElementType {
   /**
   * Returns a human-readable representation of the type of UI element that the elementType property represents.
   * This function is useful for identifying the type of an element when it is not immediately clear from its other properties.
   * The function uses the ElementTypeName enum to map the raw value of the elementType property to a human-readable string.
   * ## Examples:
   * app.buttons.firstMatch.elementType.string // "button"
   */
   public var string: String {
      ElementTypeName.allCases[Int(self.rawValue)].rawValue
   }
}
public typealias XCUIElementType = XCUIElement.ElementType
#endif
