#if canImport(XCTest)
import Foundation
import XCTest
/**
 * Slider
 */
extension ElementModifier {
   /**
    * Slides a slider to a specified position.
    * - Parameters:
    *   - slider: The slider to slide
    *   - amount: The amount to slide the slider to. The value should be between 0.0 and 1.0, where 0.0 represents the minimum value and 1.0 represents the maximum value.
    * - Remark: This function uses the `adjust(toNormalizedSliderPosition:)` method of `XCUIElement` to slide the slider to the specified position.
    * ## Examples:
    * slide(slider: app.sliders.element, amount: 0.7)
    */
   public static func slide(slider: XCUIElement, amount: CGFloat) {
      // Adjust the slider to the specified normalized position
      slider.adjust(toNormalizedSliderPosition: amount)
   }
}
#endif
