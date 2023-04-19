//
//  SceneDelegate.swift
//  Peets
//
//  Created by Juan Camilo Navarro on 19/04/23.
//

import Foundation
import SwiftUI

final class SceneDelegate: NSObject, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let coordinator: Coordinator<CatsCoordinator> = .init(
            startingRoute: .list
        )
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = coordinator.navigationController
        window?.makeKeyAndVisible()
        coordinator.start()
    }
}
