//  SceneDelegate.swift
//  AppLifecycle

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
   
        print(#function)
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {

        print(#function)
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
   
        print(#function)
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
      
        print(#function)
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
       
        print(#function)
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
        print(#function)
        
    }


}

