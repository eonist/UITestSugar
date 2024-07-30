#if canImport(XCTest)
import Foundation
import XCTest
/**
 * Slider
 */
extension ElementModifier {
   /**
    * Slides a slider to a specified position.
    * - Description: This method is used to adjust the position of a slider element within a user interface. It sets the slider's value to a specific point along its track, based on a normalized value range.
    * - Parameters:
    *   - slider: The slider element to be adjusted.
    *   - amount: The target position for the slider, expressed as a normalized value between 0.0 (minimum) and 1.0 (maximum).
    * - Remark: This function utilizes the `adjust(toNormalizedSliderPosition:)` method of `XCUIElement` to accurately set the slider to the desired position.
    * ## Examples:
    * slide(slider: app.sliders.element, amount: 0.7)
    */
   public static func slide(slider: XCUIElement, amount: CGFloat) {
      // Adjust the slider to the specified normalized position
      slider.adjust(toNormalizedSliderPosition: amount)
   }
}
#endif
