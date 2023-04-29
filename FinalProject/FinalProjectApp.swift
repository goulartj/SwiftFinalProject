//
//  FinalProjectApp.swift
//  FinalProject
//
//  Created by John Goulart on 4/27/23.
//


import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct FinalProjectApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var happyVM = HappyVideoViewModel()
    @StateObject var funnyVM = FunnyVideoViewModel()
    @StateObject var smartVM = SmartVideoViewModel()
    @StateObject var sadVM = SadVideoViewModel()
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(happyVM)
                .environmentObject(funnyVM)
                .environmentObject(smartVM)
                .environmentObject(sadVM)
        }
    }
}
