#if canImport(XCTest) && os(iOS)
import Foundation
import XCTest
/**
 * Pickerwheel
 */
extension ElementModifier {
   /**
    * Selects a specified value in a picker wheel.
    * - Description: This method sets the picker wheel to a specified value. It is useful for selecting an item from a list of options presented in a picker wheel during UI tests.
    * - Parameters:
    *   - pickerWheel: The picker wheel element to interact with.
    *   - value: The value to be selected in the picker wheel.
    * ## Examples:
    * pick(pickerWheel: app.pickerWheels.element, value: "Picker Wheel Item Title")
    * pick(pickerWheel: ElementParser.firstElement(query:  app.pickerWheels, identifier: "first picker", type:.picker), value: "Picker Wheel Item Title")
    */
   public static func pick(pickerWheel: XCUIElement, value: String) {
      // Adjust the picker wheel to the specified value
      pickerWheel.adjust(toPickerWheelValue: value)
   }
}
#endif
