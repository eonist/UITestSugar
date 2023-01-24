#if canImport(XCTest)
import XCTest

public class QueryHelper {
   /**
    * Returns all descendants of a query that are hittable
    * - Important: ⚠️️ Since we use element boundBy it may not work with waiter calls
    * ## Example:
    * hittableElements(query: app.descendants(matching: .any)).count // n
    * - Parameter query: Can be one element, children or descendants
    */
   public static func hittableElements(query: XCUIElementQuery) -> [XCUIElement] {
      (0..<query.count).indices.map { i in
         let element = query.children(matching: .other).element(boundBy: i)
         return element.isHittable ? element : nil
      }.compactMap { $0 }
   }
}
#endif
