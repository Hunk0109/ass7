import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var customers: [Customer] = []

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Create an instance of ArtistViewController
        let customerViewController = CustomerViewController()

        // Pass the artists array to the ArtistViewController instance
        customerViewController.customers = self.customers

        return true
    }
}

