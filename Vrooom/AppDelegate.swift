//
//  AppDelegate.swift
//  Vrooom
//
//  Created by Admin on 17.09.2020.
//  Copyright © 2020 Rudenko. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window:UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //realm.default setup:
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
        
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        return true
    }

  open class func getBundledRealm() -> Realm {
      let config = Realm.Configuration(
          // Get the URL to the bundled file
              fileURL: Bundle.main.url(forResource: "default", withExtension: "realm"),
              // Open the file in read-only mode as application bundles are not writeable
              readOnly: true)

      // Open the Realm with the configuration
      let realm = try! Realm(configuration: config)

      return realm
  }
}

