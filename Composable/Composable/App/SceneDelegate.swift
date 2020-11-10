//
//  SceneDelegate.swift
//  ComposableArchitecture
//
//  Created by Евгений Суханов on 19.10.2020.
//

import UIKit
import SwiftUI
import ComposableArchitecture

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let keyValueStore: KeyValueStore = KeyValueStoreImpl()
            window.rootViewController = UIHostingController(
                rootView: ShoppingListView(
                    store: ShoppingListStore(
                        initialState: ShoppingListState(),
                        reducer: shoppingListReducer,
                        environment: ShoppingListEnviroment(
                            uuidGenerator: UUID.init,
                            save: {
                                keyValueStore.set($0, forKey: "products")
                                return .none
                            },
                            load: {
                                Effect(
                                    value: keyValueStore.value(forKey: "products") ?? []
                                )
                            }
                        )
                    )
                )
            )
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

