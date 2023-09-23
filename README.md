[![Tests](https://github.com/eonist/UITestSugar/actions/workflows/Tests.yml/badge.svg)](https://github.com/eonist/UITestSugar/actions/workflows/Tests.yml)
[![codebeat badge](https://codebeat.co/badges/ab6aca0b-c9eb-486a-8209-6b0113840e0c)](https://codebeat.co/projects/github-com-eonist-uitestsugar-master)

# UITestSugar
Sugar for UITesting

### Brief overview of what UITestSugar

UITestSugar is a library that provides a set of utilities and extensions for UI testing in iOS. It can be used to simplify and streamline the process of writing UI tests, making it easier to find and interact with UI elements in your app. With UITestSugar, you can write more effective and efficient UI tests, reducing the time and effort required to test your app's user interface.

### How do I get it
- SPM: `"https://github.com/eonist/UITestSugar"`

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
- **Important:** When adding `UITestSugar` to an Xcode project via Swift Package Manager, make sure to select the `UITest target` instead of the app target. The app target cannot load the `XCTest.framework` that `UITestSugar` uses, which will cause the build to fail.
- **Note:** If you are using Carthage to manage dependencies, you need to add the correct framework search path in build settings. For more information, see [this Stack Overflow post](https://stackoverflow.com/questions/44665656/creating-a-framework-that-uses-xctest).
- **Example:** You can see an example of `UITestSugar` being nested into another testing framework in [this GitHub repository](https://github.com/eonist/TestRunner).

### Gotchas:
- Sometimes it can be difficult to access an element, such as a button inside a button in a cell. In these cases, you can try changing the app UI to make the element more accessible. For example, you can turn one button into a view or disable accessibility for one button and hit the cell itself instead, which triggers the button.
- Element labels can be used to target elements that have children with text fields or labels with text. This can be useful for finding elements that might be difficult to access using other methods.

### Resources:
- https://github.com/joemasilotti/UI-Testing-Cheat-Sheet (The selected link is a GitHub repository that provides a cheat sheet for UI testing in iOS, including tips and tricks for using Xcode's UI testing framework)
- Great primer for iOS UITesting: https://medium.com/tauk-blog/fundamentals-of-xcuitest-7dcbc23c4ee

### Example:
- When interacting with Apple's own UI, such as the Share modal in iOS, finding labels and IDs in Accessibility Inspector might not be enough. In some cases, the inspector might display a different label than the one that is actually used in the app. To find the correct label, you can log the label of each element using the `label` property and the `identifier` property. For example: `activityListView.descendants(type: .button, id: nil).allElementsBoundByIndex.forEach { Swift.print("$0.label: \($0.label) $0.identifier: \($0.identifier) ") }`.

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

### More advance screenshots:
```swift
ScreenShotMaker.makeScreenShot(testCase: self) // Put this line in your UITests where you want the screenshot to be taken
```


### Installation

GitHub Copilot: Sure, here's an example of what a section on installing `UITestSugar` using Swift Package Manager and Carthage could look like:


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

### Carthage

To install `UITestSugar` using Carthage, follow these steps:

1. Add the following line to your Cartfile: `github "eonist/UITestSugar"`.
2. Run `carthage update` to download and build the framework.
3. Drag the built framework into your Xcode project.
4. In the General tab of your app target, add the `UITestSugar.framework` to the "Frameworks, Libraries, and Embedded Content" section.
5. In the Build Phases tab of your app target, add a new "Run Script" phase with the following script: `/usr/local/bin/carthage copy-frameworks`. Add the path to the `UITestSugar.framework` to the "Input Files" section.

If you encounter any issues with the installation process, try the following troubleshooting tips:

- Make sure that you have the latest version of Carthage installed.
- Make sure that your project is configured to use Carthage. To do this, create a Cartfile in the root of your project and add the dependencies that you want to use.
- Make sure that your project is configured to use the correct version of Swift. To do this, select your project in the Project navigator, select the Build Settings tab, and make sure that the "Swift Language Version" setting is set to the correct version of Swift.

## General UITesting tips:
- Use descriptive labels and IDs for UI elements: When writing UI tests, it's important to use descriptive labels and IDs for UI elements to make it easier to find and interact with them. Avoid using generic labels like "Button" or "Label", and instead use labels that describe the purpose of the element, such as "Login Button" or "Username Label".
- Use page objects to organize your tests: Page objects are a design pattern that can help you organize your UI tests and make them more maintainable. A page object is a class that represents a page or screen in your app, and contains methods for interacting with the UI elements on that page. By using page objects, you can write tests that are more modular and easier to maintain.
- Use the waitForExistence method to wait for UI elements to appear: When interacting with UI elements in your tests, it's important to wait for them to appear before trying to interact with them. The waitForExistence method can be used to wait for an element to appear on the screen before continuing with the test.
- Use the XCTContext.runActivity method to group related test steps: The XCTContext.runActivity method can be used to group related test steps together in the Xcode test report. This can make it easier to understand the flow of the test and identify any issues that may arise.
- Use the XCTAssert methods to verify expected behavior: The XCTAssert methods can be used to verify that the app is behaving as expected during the test. Use these methods to check that UI elements are displayed correctly, that data is being loaded correctly, and that the app is responding to user input as expected.

### Todo:
- Add github actions ✅
- Maybe add some of the method in the Kif.framework?
- UITest tap should have param to set shouldFail: true

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details. The MIT License is a permissive open source license that allows you to use, copy, modify, and distribute the software for any purpose, as long as you include the original copyright and license notice.