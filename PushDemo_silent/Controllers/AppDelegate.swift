//
//  AppDelegate.swift
//  PushDemo_silent
//
//  Created by Hardik on 09/04/19.
//  Copyright © 2019 HardikDabhi. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications
import FirebaseInstanceID
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{

    var window: UIWindow?
    var isBackground = false


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        application.registerForRemoteNotifications()
        requestNotificationAuthorization(application: application)
        if let userInfo = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] {
            NSLog("[RemoteNotification] applicationState: \(applicationStateString) didFinishLaunchingWithOptions for iOS9: \(userInfo)")
            //TODO: Handle background notification
        }
        //This is the demo project 
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        self.isBackground = true
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        self.isBackground = false
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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
    
    func requestNotificationAuthorization(application: UIApplication) {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
    }
    
}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    // iOS10+, called when presenting notification in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        NSLog("[UserNotificationCenter] applicationState: \(applicationStateString) willPresentNotification: \(userInfo)")
        //TODO: Handle foreground notification
        completionHandler([.alert])
    }
    
    // iOS10+, called when received response (default open, dismiss or custom action) for a notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        NSLog("[UserNotificationCenter] applicationState: \(applicationStateString) didReceiveResponse: \(userInfo)")
        //TODO: Handle background notification
        completionHandler()
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let apnsDeviceToken = deviceToken.map {String(format: "%02.2hhx", $0)}.joined()
        
        print("Device Token",apnsDeviceToken)
        print("Instance id Token is:",InstanceID.instanceID().token())
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        print(" Entire message \(userInfo)")
        print("Article avaialble for download: \(userInfo["articleId"]!)")
        
        if(self.isBackground){
            print("Application is in backgroung mode")
            let content = UNMutableNotificationContent()
            content.title = "Message"
            content.subtitle = ""
            content.body = userInfo["articleId"] as! String
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats:false)
            let request = UNNotificationRequest(identifier: "id", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler:nil)
        }
        else{
            print("Application is in foreground mode")
        }
        
        let state : UIApplication.State = application.applicationState
        switch state {
        case UIApplication.State.active:
            print("If needed notify user about the message")
        default:
            print("Run code to download content")
        }
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
}


extension AppDelegate : MessagingDelegate {
    private func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        NSLog("[RemoteNotification] didRefreshRegistrationToken: \(fcmToken)")
    }
}


//Post man Row Content
//
//{
//    "multicast_id": 7957912632512151774,
//    "success": 1,
//    "failure": 0,
//    "canonical_ids": 0,
//    "results": [
//    {
//    "message_id": "0:1554804931206335%4fd407c64fd407c6"
//    }
//    ]
//}
//Postman Header

//Authorization:key=AAAAwjF2_h4:APA91bG2ftW_lg_ymwYJRcEsdEyzy6C1ODMRar1Uit1Q913JCVlhRsK7e-MspjjfhSgiuYf1Nmi1ggOCUxHKvnMIgJQZgbNfOqP3JCd5qxo2Vv_b2S2LEDf7ycadkIUO8DnKtQNGgusT
//Content-Type:application/json

//POST :- URL: - https://fcm.googleapis.com/fcm/send

