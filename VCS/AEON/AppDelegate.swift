//
//  AppDelegate.swift
//  AEON
//
//  Created by Mobile User on 1/24/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//


import UIKit
import CoreData
import GoogleMaps
import IQKeyboardManagerSwift
import FirebaseCore
import FirebaseMessaging
import FirebaseInstanceID

let googleApiKey = "AIzaSyA9LipdYZoY8gGLt9KGm1-ia8RHc9ul2Gk"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  // var localRemoteMessage : MessagingRemoteMessage? = nil
    let gcmMessageIDKey = "gcm.message_id"
  
    var window: UIWindow?
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        completionHandler(.newData)
        application.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalMinimum)
    }  

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
       // (UserDefaults.standard.string(forKey: Constants.USER_INFO_CUSTOMER_ID) ?? "0")
        UNUserNotificationCenterDelegate.self
               application.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalMinimum)
               if launchOptions != nil{
                   let userInfo = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification]
                 if userInfo != nil {
               // Perform action here
                   
                }
               }
       Messaging.messaging().isAutoInitEnabled = true
        do {
            try Network.reachability = Reachability(hostname: "www.google.com")
        }
        catch {
            switch error as? Network.Error {
            case let .failedToCreateWith(hostname)?:
                print("Network error:\nFailed to create reachability object With host named:", hostname)
            case let .failedToInitializeWith(address)?:
                print("Network error:\nFailed to initialize reachability object With address:", address)
            case .failedToSetCallout?:
                print("Network error:\nFailed to set callout")
            case .failedToSetDispatchQueue?:
                print("Network error:\nFailed to set DispatchQueue")
            case .none:
                print(error)
            }
        }
        
        // Google map api
        GMSServices.provideAPIKey(googleApiKey)
        
        UserDefaults.standard.register(defaults: [CommonNames.VERSION_ALERT_SHOWN: false])
        
        //IQKeyboardManager.shared.enable = true
        //IQKeyboardManager.shared.enableAutoToolbar = false
        
        if UserDefaults.standard.string(forKey: Constants.FIRST_TIME_PHONE) != nil {
           let stor = UIStoryboard.init(name: "Main", bundle: nil)
            let mainNewViewController = stor.instantiateViewController(withIdentifier: CommonNames.MAIN_NEW_VIEW_CONTROLLER) as! MainNewViewController
//            let nav = UINavigationController(rootViewController: mainNewViewController)
//            nav.navigationBar.isHidden = true
            self.window?.rootViewController = mainNewViewController
        }
      
        
        var applicationStateString: String {
                       if UIApplication.shared.applicationState == .active {
                         return "active"
                       } else if UIApplication.shared.applicationState == .background {
                         return "background"
                       }else {
                         return "inactive"
                       }
                     }
               if let userInfo = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] {
                 //TODO: Handle background notification
               }
     //  application.registerForRemoteNotifications()
      
               if let userInfo = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] {
                 //TODO: Handle background notification
               }
        
//        func requestNotificationAuthorization(application: UIApplication) {
//                   if #available(iOS 10.0, *) {
//                     UNUserNotificationCenter.current().delegate = self
//                     let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//                     UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: {_, _ in })
//                   } else {
//                     let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
//                     application.registerUserNotificationSettings(settings)
//                   }
//                 }
    
    //    requestNotificationAuthorization(application: application)
        
//        if #available(iOS 10.0, *) {
//                 
//                 UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
//                    print("granted: \(granted)")
//                     DispatchQueue.main.async {
//                         if granted {
//                             UIApplication.shared.registerForRemoteNotifications()
//                         }
//                     }
//                     
//                     
//                 }
//                 
//             } else {
//                 
//                 application.registerUserNotificationSettings(UIUserNotificationSettings(types: UIUserNotificationType(rawValue: UIUserNotificationType.sound.rawValue | UIUserNotificationType.alert.rawValue |
//                     UIUserNotificationType.badge.rawValue), categories: nil))
//             }
//        application.registerForRemoteNotifications()

        Messaging.messaging().delegate = self
        FirebaseApp.configure()
        InstanceID.instanceID().instanceID { (result, error) in
          if let error = error {
            print("Error fetching remote instance ID: \(error)")
          } else if let result = result {
            print("Remote instance ID token: \(result.token)")
           // self.instanceIDTokenMessage.text  = "Remote InstanceID token: \(result.token)"
          }
        }
       
        return true
        
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("APP is inactive.(AppDelegate)")
        Messaging.messaging().shouldEstablishDirectChannel = true
               Messaging.messaging()
        UserDefaults.standard.set(false, forKey: CommonNames.VERSION_ALERT_SHOWN)
//        let lastUseTime = BaseUIViewController.generateCurrentTimeStamp()
//        UserDefaults.standard.set(lastUseTime, forKey: Constants.LAST_USED_TIME)
        //print("Lastest Time: ", lastUseTime)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        Messaging.messaging().shouldEstablishDirectChannel = true
        Messaging.messaging()
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    print("APP is active.(AppDelegate)")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        Messaging.messaging().shouldEstablishDirectChannel = true
               Messaging.messaging()
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "AEON")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
//      // If you are receiving a notification message while your app is in the background,
//      // this callback will not be fired till the user taps on the notification launching the application.
//      // TODO: Handle data of notification
//
//      // With swizzling disabled you must let Messaging know about the message, for Analytics
//      // Messaging.messaging().appDidReceiveMessage(userInfo)
//
//      // Print message ID.
//      if let messageID = userInfo[gcmMessageIDKey] {
//        print("Message ID: \(messageID)")
//      }
//
//      // Print full message.
//      print(userInfo)
//    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
      
       
        
//
//
//      if let messageID = userInfo[gcmMessageIDKey] {
//        print("Message ID: \(messageID)")
//      }
//    InstanceID.instanceID().instanceID { (result, error) in
//      if let error = error {
//        print("Error fetching remote instance ID: \(error)")
//      } else if let result = result {
//        print("Remote instance ID token: \(result.token)")
//      //  self.instanceIDTokenMessage.text  = "Remote InstanceID token: \(result.token)"
//      }
//    }
//
//        switch application.applicationState {
//                  case .active:
//                      let content = UNMutableNotificationContent()
//                      if let title = userInfo["title"]
//                      {
//                          content.title = title as! String
//                      }
//                      if let title = userInfo["body"]
//                      {
//                          content.body = title as! String
//                      }
//                      content.userInfo = userInfo
//                      if #available(iOS 12.0, *) {
//                          content.sound = UNNotificationSound.defaultCritical
//                      } else {
//                      }
//                      let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 0.1, repeats: false)
//                      let request = UNNotificationRequest(identifier:"rig", content: content, trigger: trigger)
//                      UNUserNotificationCenter.current().delegate = self
//                      UNUserNotificationCenter.current().add(request) { (error) in
//                          if let getError = error {
//                              print(getError.localizedDescription)
//                          }
//                      }
//                  case .inactive:
//
//                      break
//                  case .background:
//
//                      break
//        @unknown default:
//            fatalError()
//        }
//
//
//
//
//
//      print(userInfo)
      completionHandler(UIBackgroundFetchResult.newData)
    
    }
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        let deviceTokenString = deviceToken.hexString
//         let fcmDeviceToken = Messaging.messaging().fcmToken
//        print("mydeviceToken : \(deviceToken)")
//        print(fcmDeviceToken as Any)
//       print(deviceTokenString)
//
//    }
//    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
//        print("my error: \(error)")
//    }

}

extension AppDelegate : MessagingDelegate {
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        
        
    }
 
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        
        print(fcmToken)
        Messaging.messaging().subscribe(toTopic: "regular")
        Messaging.messaging().shouldEstablishDirectChannel = true
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        InstanceID.instanceID().instanceID { (result, error) in
//            if let error = error {
//            } else if let result = result {
//                // self.instanceIDTokenMessage.text  = "Remote InstanceID token: \(result.token)"
//            }
        }
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    // [END refresh_token]
    // [START ios_10_data_message]
    // Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
    // To enable direct data messages, you can set Messaging.messaging().shouldEstablishDirectChannel to true.
//    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
//
//        let type : String = remoteMessage.appData["type"] as! String
//        if type == "product" {
//
//
//            localRemoteMessage = remoteMessage
//
//            let content = UNMutableNotificationContent()
//
//            content.title = NSString.localizedUserNotificationString(forKey: "\(remoteMessage.appData["body"]!)", arguments: nil)
//            content.body = NSString.localizedUserNotificationString(forKey: "\(remoteMessage.appData["title"]!)", arguments: nil)
//            content.sound = UNNotificationSound.default
//
//               if #available(iOS 12.0, *) {
//                   content.sound = UNNotificationSound.defaultCritical
//               } else {
//               }
//               let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 0.2, repeats: false)
//               let request = UNNotificationRequest(identifier:"rig", content: content, trigger: trigger)
//               UNUserNotificationCenter.current().delegate = self
//               UNUserNotificationCenter.current().add(request) { (error) in
////                   if let getError = error {
////                       print(getError.localizedDescription)
////                   }
//               }
//
//
//        }
//
//
//    }
//
    
    
    // [END ios_10_data_message]
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
           return true
       }
       
}

//@available(iOS 10, *)
//extension AppDelegate : UNUserNotificationCenterDelegate {
//
//    @available(iOS 10.0, *)
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//      let userInfo = response.notification.request.content.userInfo
//        if response.notification.request.identifier == "rig" {
//
//           let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//           // instantiate the view controller from storyboard
//           if  let conversationVC = storyboard.instantiateViewController(withIdentifier: "MessagingViewController") as? MessagingViewController {
//
//               // set the view controller as root
//               self.window?.rootViewController = conversationVC
//           }
//
//           // tell the app that we have finished processing the user’s action / response
//           completionHandler()
//
//
//
//        }
//         completionHandler()
//    }
//    func preparePushNotifications(for application: UIApplication) {
//        UNUserNotificationCenter.current().requestAuthorization(options: [.badge,.alert,.sound]) { (granted, error) in
//            guard granted else {
//                return
//            }
//            DispatchQueue.main.async {
//                application.registerForRemoteNotifications()
//            }
//        }
//    }
//
//   //Receive displayed notifications for iOS 10 devices.
//  func userNotificationCenter(_ center: UNUserNotificationCenter,
//                              willPresent notification: UNNotification,
//    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//let content = UNMutableNotificationContent()
//    let userInfo = notification.request.content.userInfo
//    let customerId = (UserDefaults.standard.string(forKey: Constants.USER_INFO_CUSTOMER_ID) ?? "0")
//    let CustomerInfoID:String = userInfo["customer_id"] as! String
//    if CustomerInfoID == customerId {
//        completionHandler([[.alert, .sound,.badge]])
//    }else if CustomerInfoID == "A350"{
//        completionHandler([[.alert, .sound,.badge]])
//
//    }
//
//    if let messageID = userInfo[gcmMessageIDKey] {
//      print("Message ID: \(messageID)")
//    }
//
//
//    print(userInfo)
//
//  }
//
//
//
//
//
//
//}
//extension Data {
//    var hexString: String{
//        let hexString = map {String(format: "%02.2hhx",$0)
//          }.joined()
//          return hexString
//    }
//
//}
