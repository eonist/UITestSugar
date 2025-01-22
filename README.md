[![Tests](https://github.com/eonist/UITestSugar/actions/workflows/Tests.yml/badge.svg)](https://github.com/eonist/UITestSugar/actions/workflows/Tests.yml)
[![codebeat badge](https://codebeat.co/badges/ab6aca0b-c9eb-486a-8209-6b0113840e0c)](https://codebeat.co/projects/github-com-eonist-uitestsugar-master)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![SwiftPM](https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![iOS](https://img.shields.io/badge/iOS-17%2B-blue.svg)](https://developer.apple.com/ios/)
[![macOS](https://img.shields.io/badge/macOS-14%2B-blue.svg)](https://developer.apple.com/macos/)
![Swift 5.9](https://img.shields.io/badge/Swift-5.9-orange.svg)


# UITestSugar
Sugar for UITesting

### Description

`UITestSugar` is a Swift library that provides a collection of utilities and extensions to simplify UI testing in iOS and macOS applications. It streamlines the process of writing UI tests by offering convenient methods for interacting with UI elements, taking screenshots, and debugging UI hierarchies.

### Brief overview of what UITestSugar

- UITestSugar is a library that provides a set of utilities and extensions for UI testing in iOS and macOS.
- It can be used to simplify and streamline the process of writing UI tests, making it easier to find and interact with UI elements in your app.
- With UITestSugar, you can write more effective and efficient UI tests, reducing the time and effort required to test your app's user interface.

### How do I get it
- SPM: `"https://github.com/eonist/UITestSugar"`

> [!IMPORTANT]
> When adding `UITestSugar`, make sure to select the UITest target instead of the app target. The app target cannot load the `XCTest.framework` that `UITestSugar` uses, which will cause the build to fail.

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

### Taking Screenshots

`UITestSugar` provides the `ScreenShotMaker` utility to capture screenshots during UI tests.

```swift
import UITestSugar
import XCTest

class MyUITests: XCTestCase {
   func testExample() {
      let app = XCUIApplication()
      app.launch()

      // Capture a screenshot of the entire screen
      ScreenShotMaker.makeScreenShot(name: "FullScreen", testCase: self)

      // Capture a screenshot of a specific app window (macOS only)
      ScreenShotMaker.makeScreenShot(name: "AppWindow", testCase: self, app: app, useWin: true)
   }
}
```

> [!NOTE] 
> The screenshots will be attached to your test results and can be viewed in Xcode's **Reports** navigator.

**Example: Entering Text into a Text Field**

```swift
import UITestSugar
import XCTest

class MyUITests: XCTestCase {
      func testEnterText() {
         let app = XCUIApplication()
         app.launch()

         if let textField = app.firstDescendant(type: .textField) {
            textField.clearAndEnterText(text: "Hello, UITestSugar!")
         }
      }
}
```

**Apples own UI**
- When interacting with Apple's own UI, such as the Share modal in iOS, finding labels and IDs in Accessibility Inspector might not be enough. In some cases, the inspector might display a different label than the one that is actually used in the app. To find the correct label, you can log the label of each element using the `label` property and the `identifier` property. For example: `activityListView.descendants(type: .button, id: nil).allElementsBoundByIndex.forEach { Swift.print("$0.label: \($0.label) $0.identifier: \($0.identifier) ") }`.

```swift
activityListView.descendants(type: .button, id: nil).allElementsBoundByIndex.forEach {  
   Swift.print("$0.label: \($0.label) $0.identifier: \($0.identifier) ") // "XCElementSnapshotPrivilegedValuePlaceholder" // This was found by doing // activityListView.descendants(type: .button, id: nil).allElementsBoundByIndex.forEach {  Swift.print("$0.label: \($0.label) $0.identifier: \($0.identifier) ") }
}
```

### Great for debugging hirarchy

```swift
import UITestSugar
import XCTest

class MyUITests: XCTestCase {
      func testDebugHierarchy() {
         let app = XCUIApplication()
         app.launch()

         // Generate and print the hierarchy string
         let hierarchyStr = ElementDebugger.debugHierarchy(element: app, type: .any)
         print("Hierarchy: \n" + hierarchyStr)
      }
}
```
 
> [!NOTE]
> Be cautious when debugging the entire application hierarchy, as it can take a significant amount of time for complex UIs.

### Installation

To install `UITestSugar` using Swift Package Manager, follow these steps:

1. In Xcode, select File > Swift Packages > Add Package Dependency.
2. Enter the URL for the `UITestSugar` repository: `https://github.com/eonist/UITestSugar`.
3. Select the version of `UITestSugar` that you want to use.
4. Choose the target where you want to add `UITestSugar`.
5. Click Finish.

If you encounter any issues with the installation process, try the following troubleshooting tips:

- Make sure that you have the latest version of Xcode installed.
- Make sure that your project is configured to use Swift Package Manager. To do this, select your project in the Project navigator, select the Swift Packages tab, and make sure that the "Enable Swift Packages" checkbox is selected.
- Make sure that your project is configured to use the correct version of Swift. To do this, select your project in the Project navigator, select the Build Settings tab, and make sure that the "Swift Language Version" setting is set to the correct version of Swift.

> [!NOTE]
> **Example:** You can see an example of `UITestSugar` being nested into another testing framework in [this GitHub repository](https://github.com/eonist/TestRunner).

## General UITesting tips:
- Use descriptive labels and IDs for UI elements: When writing UI tests, it's important to use descriptive labels and IDs for UI elements to make it easier to find and interact with them. Avoid using generic labels like "Button" or "Label", and instead use labels that describe the purpose of the element, such as "Login Button" or "Username Label".
- Use page objects to organize your tests: Page objects are a design pattern that can help you organize your UI tests and make them more maintainable. A page object is a class that represents a page or screen in your app, and contains methods for interacting with the UI elements on that page. By using page objects, you can write tests that are more modular and easier to maintain.
- Use the waitForExistence method to wait for UI elements to appear: When interacting with UI elements in your tests, it's important to wait for them to appear before trying to interact with them. The waitForExistence method can be used to wait for an element to appear on the screen before continuing with the test.
- Use the XCTContext.runActivity method to group related test steps: The XCTContext.runActivity method can be used to group related test steps together in the Xcode test report. This can make it easier to understand the flow of the test and identify any issues that may arise.
- Use the XCTAssert methods to verify expected behavior: The XCTAssert methods can be used to verify that the app is behaving as expected during the test. Use these methods to check that UI elements are displayed correctly, that data is being loaded correctly, and that the app is responding to user input as expected.
- If you encounter strage bugs whule using doing UITesting in XCode. It is recommend you clean and delete derived data often, as well as restart XCode from time to time.
- Print the entire UI:  `Swift.print(app.debugDescription)` 

### Gotchas:
- Sometimes it can be difficult to access an element, such as a button inside a button in a cell. In these cases, you can try changing the app UI to make the element more accessible. For example, you can turn one button into a view or disable accessibility for one button and hit the cell itself instead, which triggers the button.
- Element labels can be used to target elements that have children with text fields or labels with text. This can be useful for finding elements that might be difficult to access using other methods.
- QuickTime can be used to record UItests, in order to pinpoint errors that happend etc. Sometimes logs can be hard to decipher etc.

### Resources:
- [UI Testing Cheat Sheet](https://github.com/joemasilotti/UI-Testing-Cheat-Sheet): A comprehensive guide for UI testing in iOS.
- [Fundamentals of XCUITest](https://medium.com/tauk-blog/fundamentals-of-xcuitest-7dcbc23c4ee): An excellent primer on UI testing with XCUITest.
- [Creating Screenshots in UI Tests](https://www.appsdeveloperblog.com/xcuiscreenshot-creating-screenshots-in-ui-test/): Learn more about capturing screenshots during UI testing.
- [Debugging UI Hierarchies](https://developer.apple.com/documentation/xctest/xcuielement/1500898-debugdescription): Official documentation on debugging UI hierarchies.

### Todo:
- [x] Add GitHub Actions
- [ ] Maybe add some of the methods from the KIF framework
- [ ] UITest tap should have a parameter to set `shouldFail: true`
- [ ] Add example GIF to README
- [ ] Write about differences when using this with SwiftUI

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details. The MIT License is a permissive open source license that allows you to use, copy, modify, and distribute the software for any purpose, as long as you include the original copyright and license notice.
