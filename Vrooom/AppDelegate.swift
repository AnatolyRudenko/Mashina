//
//  AppDelegate.swift
//  Vrooom
//
//  Created by Admin on 17.09.2020.
//  Copyright © 2020 Rudenko. All rights reserved.
//

import UIKit
import RealmSwift
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.setupRealmDB()
        IQKeyboardManager.shared.enable = true
        
        return true
    }

    private func setupRealmDB() { //preloaded DB extraction
        let defaultPath = Realm.Configuration.defaultConfiguration.fileURL?.path
        let path = Bundle.main.path(forResource: "default", ofType: "realm")
        if !FileManager.default.fileExists(atPath: defaultPath!), let bundledPath = path {
            do {
                try FileManager.default.copyItem(atPath: bundledPath, toPath: defaultPath!)
            } catch {
                print("Error copying pre-populated Realm \(error)")
            }
        }
        do {
            _ = try Realm()
        } catch {
            print("error initializing Realm: \(error)")
        }
    }
}

