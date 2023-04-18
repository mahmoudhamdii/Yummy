//
//  SceneDelegate.swift
//  Yummy
//
//  Created by hamdi on 22/02/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
       
        var controller :UIViewController!
        if UserDefaults.standard.hasOnboarded {
            //cheak auth
            if UserDefaults.standard.hasAuthorization {
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                controller = storyBoard.instantiateViewController(withIdentifier: "MainSB")
            }else{
              
                let storyBoard = UIStoryboard(name: "UserAuthorizationUI", bundle: nil)
                controller = storyBoard.instantiateViewController(withIdentifier: "login&signup")
            }
            
            
        }
        else{
            controller  = OnboardingViewController.instantiate(storyBord: "OnBordingUI")

        }
        
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }


}

