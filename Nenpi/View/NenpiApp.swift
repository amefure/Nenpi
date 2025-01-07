//
//  NenpiApp.swift
//  Nenpi
//
//  Created by t&a on 2022/07/02.
//

import SwiftUI
import FirebaseCore
import GoogleMobileAds

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        FirebaseApp.configure()
        return true
    }
}

@main
struct NenpiApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
      
      var body: some Scene {
          WindowGroup {
              RootView()
          }
      }
  }
