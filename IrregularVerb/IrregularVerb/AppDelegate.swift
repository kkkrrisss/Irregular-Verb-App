//
//  AppDelegate.swift
//  IrregularVerb
//
//  Created by Кристина Олейник on 30.07.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds) //инициализация начального окна, делаем его под размер экрана
        //запускаем приложение с использованием NavigationViewController
        if let window = window {
            let navigationController = UINavigationController()
            navigationController.viewControllers = [HomeViewController()]
            window.rootViewController = navigationController
            window.makeKeyAndVisible() //делаем видимым
            
        }
        return true
    }


}

