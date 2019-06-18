
import XCTest
//@testable import UITestDemo
@testable import UITestDemo

class UITestDemoTests: XCTestCase {
   
   override func setUp() {
      // Put setup code here. This method is called before the invocation of each test method in the class.
      
      
      let homeNavButton = NavigationHelper.tabButton(tabButtonName: "home")
      Swift.print("homeNavButton:  \(homeNavButton)")
      let numOfHittableElements = XCUIApplication().descendants(matching: .any).hittableElements.count
      Swift.print("numOfHittableElements:  \(numOfHittableElements)")
      
      let app = XCUIApplication()
      let searchedElement = app.filterElements(containing: "Sugar", "500 g").element
      let elementExists = searchedElement.exists // true , false
      Swift.print("elementExists:  \(elementExists)")
      searchedElement.firstMatch.tap()
   }
   
   override func tearDown() {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
   }
   
   func testExample() {
      // This is an example of a functional test case.
      // Use XCTAssert and related functions to verify your tests produce the correct results.
   }
   
   func testPerformanceExample() {
      // This is an example of a performance test case.
      self.measure {
         // Put the code you want to measure the time of here.
      }
   }
   
}

