[![Tests](https://github.com/eonist/UITestSugar/actions/workflows/Tests.yml/badge.svg)](https://github.com/eonist/UITestSugar/actions/workflows/Tests.yml)
[![codebeat badge](https://codebeat.co/badges/ab6aca0b-c9eb-486a-8209-6b0113840e0c)](https://codebeat.co/projects/github-com-eonist-uitestsugar-master)

# UITestSugar
Sugar for UITesting

### How do I get it
- SPM: ` "https://github.com/eonist/UITestSugar"`

### By button label title
```swift
let app = XCUIApplication()
let button = ElementParser.firstDescendant(element: app, condition: { $0.label == "Detail" })
Swift.print("button?.label:  \(button?.label)")
```

### By button accessibility
```swift
btn.isAccessibilityElement = true // set this in the app code
btn.accessibilityIdentifier = "detailBtn" // set this in the app code
let button = ElementParser.firstDescendant(element: app, condition: { $0.identifier == "detailBtn" })
```

### Get label-text from cell:
```swift
let labelText: String? = app.firstDescendant({$0.elementType == .table})?.descendants(matching: .cell).firstMatch.children(matching: .staticText).element.label
Swift.print("labelText:  \(labelText)") // some cell text
```

### Generic example:
```swift
let app = XCUIApplication()
let searchedElement = app.filterElements(containing: "Sugar", "500 g").element
searchedElement.exists // true , false
searchedElement.firstMatch.tap()
```

### Note:
- Important: When adding `UITestSugar` to an xcode project via xcode swift package manager `file -> add package`. Make sure you pick the `UITest target`, not the app target. The app target can't load the `XCTest.framework` that the `UITestSugar` uses. And will fail.
- (This is for carthage I think) When you make frameworks that import XCTest, you need to add the correct framework search path in build settings see: [https://stackoverflow.com/questions/44665656/creating-a-framework-that-uses-xctest](https://stackoverflow.com/questions/44665656/creating-a-framework-that-uses-xctest)
- You can also see an example of this framework being nested into Another TestingFramework: [https://github.com/eonist/TestRunner](https://github.com/eonist/TestRunner)

### Gotchas:
- Sometimes it's hard to get to an element, like button inside a button in a cell. The trick can sometimes be to change the app UI. Like make one button a view. And sometimes just thinking outside the box works. like turning of acceccibility for one button and hitting the cell it self instead, which triggers the button etc.
- Element label can be used to target elements that has children with textfield or labels with text

### Resources:
- https://github.com/joemasilotti/UI-Testing-Cheat-Sheet
- Great primer for iOS UITesting: https://medium.com/tauk-blog/fundamentals-of-xcuitest-7dcbc23c4ee

### Example:
When interacting with apples own UI (Example below is the Share modal iOS). Finding labels and ids in Accessibility Inspector might not be enough. In the inspector it will say label is "Activity" but in reality if you log the label its: "XCElementSnapshotPrivilegedValuePlaceholder" // This was found by doing // activityListView.descendants(type: .button, id: nil).allElementsBoundByIndex.forEach {  Swift.print("$0.label: \($0.label) $0.identifier: \($0.identifier) ") }
```swift
activityListView.descendants(type: .button, id: nil).allElementsBoundByIndex.forEach {  
   Swift.print("$0.label: \($0.label) $0.identifier: \($0.identifier) ") // "XCElementSnapshotPrivilegedValuePlaceholder" // This was found by doing // activityListView.descendants(type: .button, id: nil).allElementsBoundByIndex.forEach {  Swift.print("$0.label: \($0.label) $0.identifier: \($0.identifier) ") }
}
```

### Great for debugging hirarchy

```swift
let hierarchyStr: String = ElementDebugger.debugHierarchy(element: app, type: .any, indentationLevel: 1)
Swift.print("Hierarchy: \n" + hierarchyStr)
```

### Take screenshot:
```swift
ScreenShotMaker.makeScreenShot() // Put this line in your UITests where you want the screenshot to be taken
```

### Todo:
- Add github actions ✅
- Maybe add some of the method in the Kif.framework?
