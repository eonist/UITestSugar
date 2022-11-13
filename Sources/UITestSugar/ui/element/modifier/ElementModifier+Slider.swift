#if canImport(XCTest)
import Foundation
import XCTest
/**
 * Slider
 */
extension ElementModifier {
   /**
    * - Parameters:
    *   - slider: The slider to slide
    *   - amount: The amount to slide the slider to
    * ## Examples:
    * slide(slider: app.sliders.element, amount: 0.7)
    */
   public static func slide(slider: XCUIElement, amount: CGFloat) {
      slider.adjust(toNormalizedSliderPosition: amount)
   }
}
#endif
