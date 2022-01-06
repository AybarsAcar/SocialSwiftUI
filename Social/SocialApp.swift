//
//  SocialApp.swift
//  Social
//
//  Created by Aybars Acar on 5/1/2022.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn


@main
struct SocialApp: App {
  
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}


class AppDelegate: NSObject, UIApplicationDelegate {
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    FirebaseApp.configure()
    
    return true
  }
  
  @available(iOS 9.0, *)
  func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
    return GIDSignIn.sharedInstance.handle(url)
  }
}
