//
//  AppDelegate.swift
//  Brewery
//
//  Created by Denrick on 2/11/21.
//

import UIKit
import Unrealm

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupRealm()
        return true
    }
    
    private func setupRealm() {
        Realm.registerRealmables([BeerResponse.self])
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        Realm.Configuration.defaultConfiguration = config
        
        guard let realm = try? Realm() else { return }
        print("Realm file is located here: \(realm.configuration.fileURL?.debugDescription ?? "")")
    }
}
