import Foundation
/**
 * Supports fractional time for sleeping.
 * - Remark: This function pauses the execution of a test for the specified duration in seconds. It supports fractional time, which means that you can specify a duration with a decimal point, such as 2.5 seconds.
 * - Remark: This function is useful for pausing the execution of a test for a specific duration. You can use it to simulate delays in your app and ensure that your app behaves correctly under different conditions.
 * ## Example:
 * sleep(sec: 2.5) // sleeps for 2.5 seconds
 * - Parameter sec: The duration in seconds to sleep.
 */
public func sleep(sec: Double) {
    // Wait for the specified duration in seconds
    usleep(useconds_t(sec * 1_000_000))
}
