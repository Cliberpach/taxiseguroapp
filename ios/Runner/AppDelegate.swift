import UIKit
import Flutter
import Googlemaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyA_YV6zGdrMGbIeXGgGt8AzEvjZQZtIVUE")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
