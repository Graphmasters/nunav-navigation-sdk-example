import CoreLocation
import Foundation
import NunavDesignSystem
import NunavSDK
import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UIHostingController(rootView: MainView(selectionAction: { coordinate in
            guard let viewController = try? NavigationUI.makeNavigationUI(
                destinationCoordinate: coordinate
            ) else {
                return
            }
            window.rootViewController?.present(viewController, animated: true)
        }))
        self.window = window
        window.makeKeyAndVisible()
    }
}

struct MainView: View {
    private let selectionAction: (CLLocationCoordinate2D) -> Void

    init(selectionAction: @escaping (CLLocationCoordinate2D) -> Void) {
        self.selectionAction = selectionAction
    }

    var body: some View {
        VStack {
            Text("Navigation Targets")
            PrimaryButton(title: "Graphmasters Headquarter") {
                selectionAction(CLLocationCoordinate2D(latitude: 52.41289, longitude: 9.63255))
            }
            PrimaryButton(title: "Hanover Main Station") {
                selectionAction(CLLocationCoordinate2D(latitude: 52.37769, longitude: 9.74343))
            }
            PrimaryButton(title: "Invalid") {
                selectionAction(CLLocationCoordinate2D(latitude: 0, longitude: 0))
            }
        }.padding()
    }
}
