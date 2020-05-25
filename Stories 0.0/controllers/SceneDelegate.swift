//
//  SceneDelegate.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 15/01/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
      
        

        configureinitailview()
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    
    func configureinitailview(){
        var initalcontroller : UIViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if Auth.auth().currentUser == nil{
              self.window?.rootViewController?.showLoginViewController()
        }
        if Auth.auth().currentUser != nil {
                     print(Auth.auth().currentUser!)
                     print("ravi")
                initalcontroller  = storyboard.instantiateViewController(withIdentifier: "hview")
            self.window?.rootViewController = initalcontroller
                
                 } else {
            self.window?.rootViewController?.showLoginViewController()
              
                 }
        self.window!.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}
