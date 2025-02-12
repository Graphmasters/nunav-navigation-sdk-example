import CoreLocation
import Foundation
import NunavDesignSystem
import SwiftUI
import UIKit
import NunavNavigationSDK

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UIHostingController(
            rootView: MainView(
                selectionAction: { destinationConfiguration, routingConfig in
                    guard let viewController = try? NunavNavigationUI.makeNavigationViewController(
                        destinationConfiguration: destinationConfiguration,
                        routingConfiguration: routingConfig
                    ) else {
                        return
                    }
                    window.rootViewController?.present(viewController, animated: true)
                })
        )
        self.window = window
        window.makeKeyAndVisible()
    }
}
