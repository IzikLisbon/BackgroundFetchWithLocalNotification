import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    /** Set the background fetch to run whenever possible. */
    application.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
    
    /** Createa notification settings that notify using both, alerts and badges */
    let noficationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge], categories: nil)
    
    /** register notificaitons with the above settings */
    application.registerUserNotificationSettings(noficationSettings)

    return true
  }
  
  /** Called by the OS to fetch small amounts of content opportunistically (="It is not a guarantee that the system will actually invoke this method). When a good opportunity arises, the system wakes or launches the app into the background and calls this method’") */
  func application(application: UIApplication, performFetchWithCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
    
    // TODO: Fetch from server
    raiseLocalNotificaion(application)
    completionHandler(.NewData)
  
  }
  
  /** Raise a notification with a badge and an alert. Alert has both, title and body. */
  private func raiseLocalNotificaion(application: UIApplication) {
    let localNotificaiton = UILocalNotification()
    localNotificaiton.repeatInterval = NSCalendarUnit(rawValue: 0) // don't repeat
    localNotificaiton.alertBody = "Some informative text"
    localNotificaiton.applicationIconBadgeNumber = 1
    
    // alertTitle is availble from OS 8.2
    let osVersion_8_2 = NSOperatingSystemVersion(majorVersion: 8, minorVersion: 2, patchVersion: 0)
    if NSProcessInfo().isOperatingSystemAtLeastVersion(osVersion_8_2) {
      localNotificaiton.alertTitle = "some title"
    }
    
    application.presentLocalNotificationNow(localNotificaiton)
    
  }
}
