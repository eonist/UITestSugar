import UIKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
   lazy var window: UIWindow? = {
      let win = UIWindow(frame: UIScreen.main.bounds)
      let vc = MainVC()
      win.rootViewController = vc
      win.makeKeyAndVisible()/*Important since we have no Main storyboard anymore*/
      return win
   }()
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      _ = window
      return true
   }
}
/**
 * ViewController
 */
class MainVC: UIViewController {
   override func viewDidLoad() {
      super.viewDidLoad()
      view = MainView()
      view.backgroundColor = .orange
   }
   override var prefersStatusBarHidden: Bool { true }
}
class MainView: UIView {
   lazy var btn: UIButton = createButton()
   override init(frame: CGRect) {
      super.init(frame: frame)
      _ = btn
   }
   /**
    * Boilerplate
    */
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
extension MainView {
   /**
    * Creates button
    */
   func createButton() -> UIButton {
      let btn: UIButton = .init(type: .system) // Create a new UIButton instance with the specified type
      btn.backgroundColor = .gray // Set the background color of the button
      btn.setTitle("Button", for: .normal) // Set the title of the button for the normal state
      btn.setTitleColor(.black, for: .normal) // Set the title color of the button for the normal state
      btn.titleLabel?.textAlignment = .center // Set the text alignment of the button's title label
      btn.titleLabel?.font =  .systemFont(ofSize: 12) // Set the font of the button's title label
      btn.frame = CGRect(x: 0, y: 0, width: 100, height: 50) // Set the frame of the button
      btn.addTarget(self, action: #selector(buttonTouched), for: .touchUpInside) // Add a target and action for the button
      btn.accessibilityIdentifier = "theBtn" // Set the accessibility identifier of the button
      self.addSubview(btn) // Add the button as a subview of the current view
      return btn // Return the button instance
   }
   @objc func buttonTouched(sender: UIButton) {
      Swift.print("It Works!!!")
   }
}
