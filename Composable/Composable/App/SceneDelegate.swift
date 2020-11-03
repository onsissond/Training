//
//  SceneDelegate.swift
//  ComposableArchitecture
//
//  Created by Евгений Суханов on 19.10.2020.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(
                rootView: ShoppingListView(store: .mock)
            )
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

