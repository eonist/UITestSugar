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
- Important: When adding UITestSugar to an xcode project via xcode swift package manager file -> add package. Make sure you pick the UITest target, not the app target. The app target cant load the XCTest.framework that the UITestSugar uses. And will fail.
- (This is for carthage I think) When you make frameworks that import XCTest, you need to add the correct framework search path in build settings see: [https://stackoverflow.com/questions/44665656/creating-a-framework-that-uses-xctest](https://stackoverflow.com/questions/44665656/creating-a-framework-that-uses-xctest)
- You can also see an example of this framework being nested into Another TestingFramework: [https://github.com/eonist/TestRunner](https://github.com/eonist/TestRunner)

### Todo:
- Make helper method (reusable routines) for:
- Press all of the back buttons until there aren’t any
- Add github actions 👈
- Scroll down an entire page length ✅
- Search down a scroll view until it finds a certain element ✅
- Maybe add some of the method in the Kif.framework?
