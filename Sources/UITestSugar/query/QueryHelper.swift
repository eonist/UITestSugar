#if canImport(XCTest)
import XCTest
/**
 * A utility class that provides helper methods for working with `XCUIElementQuery` objects.
 */
public class QueryHelper {
   /**
    * Returns an array of all hittable descendants of a given query.
    * This function searches for all descendants of a query that are hittable, and returns them as an array.
    * - Important: ⚠️️ This function uses `element(boundBy:)`, which may not work with waiter calls.
    * - Parameter query: The query to search for hittable descendants. This can be a single element, or a collection of children or descendants.
    * - Returns: An array of all hittable descendants found in the query.
    * ## Example:
    * ```
    * hittableElements(query: app.descendants(matching: .any)).count // n
    * ```
   */
   public static func hittableElements(query: XCUIElementQuery) -> [XCUIElement] {
      // Get the indices of all the elements in the query
      (0..<query.count).indices.map { i in
         // Get the i-th element in the query
         let element = query.children(matching: .other).element(boundBy: i)
         // Check if the element is hittable, and return it if it is
         return element.isHittable ? element : nil
      // Remove any nil elements from the array
      }.compactMap { $0 }
   }
}
#endif
