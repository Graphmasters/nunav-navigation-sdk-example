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
                selectionAction: { coordinate, routingConfig in
                    guard let viewController = try? NunavNavigationUI.makeNavigationViewController(
                        destinationConfiguration: DestinationConfiguration(coordinate: coordinate),
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


struct MainView: View {
    private let selectionAction: (CLLocationCoordinate2D, RoutingConfiguration) -> Void

    @State private var selectedTransportMode: TransportMode = .car
    @State private var avoidTollRoads: Bool = false
    @State private var selectedTarget: NavigationTarget = .graphmastersHeadquarter

    init(selectionAction: @escaping (CLLocationCoordinate2D, RoutingConfiguration) -> Void) {
        self.selectionAction = selectionAction
    }

    var body: some View {
            VStack(spacing: 20) {
                Text("Navigation Configuration")
                    .font(.headline)

                Picker("Select Target", selection: $selectedTarget) {
                    ForEach(NavigationTarget.allCases) { target in
                        Text(target.rawValue).tag(target)
                    }
                }
                .pickerStyle(MenuPickerStyle())

                Picker("Select Transport Mode", selection: $selectedTransportMode) {
                    Text("Bicycle").tag(TransportMode.bicycle)
                    Text("Bus").tag(TransportMode.bus)
                    Text("Car").tag(TransportMode.car)
                    Text("Pedestrian").tag(TransportMode.pedestrian)
                    Text("Truck").tag(TransportMode.truck)
                }
                .pickerStyle(MenuPickerStyle())

                Toggle(isOn: $avoidTollRoads) {
                    Text("Avoid Toll Roads")
                }
                .padding()

                FilledButton(title: "Start Navigation") {
                    selectionAction(
                        selectedTarget.coordinates,
                        currentRoutingConfiguration()
                    )
                }
            }
            .padding()
        }

        private func currentRoutingConfiguration() -> RoutingConfiguration {
            RoutingConfiguration(
                transportMode: selectedTransportMode,
                avoidTollRoads: avoidTollRoads,
                contextToken: nil
            )
        }
    }

    // Enum for Navigation Targets
    enum NavigationTarget: String, CaseIterable, Identifiable {
        case graphmastersHeadquarter = "Graphmasters Headquarter"
        case hanoverMainStation = "Hanover Main Station"
        case invalid = "Invalid"

        var id: String { self.rawValue }

        var coordinates: CLLocationCoordinate2D {
            switch self {
            case .graphmastersHeadquarter:
                return CLLocationCoordinate2D(latitude: 52.41289, longitude: 9.63255)
            case .hanoverMainStation:
                return CLLocationCoordinate2D(latitude: 52.37769, longitude: 9.74343)
            case .invalid:
                return CLLocationCoordinate2D(latitude: 0, longitude: 0)
            }
        }
    }
