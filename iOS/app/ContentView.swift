//
//  ContentView.swift
//  ExampleApp
//
//  Created by Florian Herzog on 06.02.25.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI
import NunavNavigationSDK
import NunavDesignSystem
import CoreLocation

struct MainView: View {
    private let selectionAction: (CLLocationCoordinate2D, RoutingConfiguration) -> Void

    @State private var selectedTransportMode: TransportMode = .car
    @State private var avoidTollRoads: Bool = false
    @State private var selectedTarget: NavigationTarget = .graphmastersHeadquarter

    init(selectionAction: @escaping (CLLocationCoordinate2D, RoutingConfiguration) -> Void) {
        self.selectionAction = selectionAction
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .large) {
            VStack(alignment: .leading, spacing: .small) {
                HeadlineText("NUNAV Navigation SDK", style: .large)
                HeadlineText(
                    "by Graphmasters GmbH",
                    style: .small(textColor: .DesignSystem.onSurfaceSecondary)
                )
            }
            ScrollView {

                Card(header: .init(title: "Navigation Example")) {
                    BodyText(
                    """
This example app demonstrates how to use the NUNAV Navigation SDK in your app to navigate to predefined targets.

Select a target and a transport mode to start the navigation. The navigation will be started with the selected transport mode and the target coordinates. Optionally, you can avoid toll roads.
"""
                    )
                }

                Card(header: .init(title: "Navigation Configuration")) {
                    VStack(alignment: .leading, spacing: .default) {
                        Picker("Select Target", selection: $selectedTarget) {
                            ForEach(NavigationTarget.allCases) { target in
                                Text(target.rawValue).tag(target)
                            }
                        }
                        .pickerStyle(.menu)

                        Picker("Select Transport Mode", selection: $selectedTransportMode) {
                            Text("Bicycle").tag(TransportMode.bicycle)
                            Text("Bus").tag(TransportMode.bus)
                            Text("Car").tag(TransportMode.car)
                            Text("Pedestrian").tag(TransportMode.pedestrian)
                            Text("Truck").tag(TransportMode.truck)
                        }
                        .pickerStyle(.menu)

                        Toggle(isOn: $avoidTollRoads) {
                            Text("Avoid Toll Roads")
                        }
                    }
                }

                FilledButton(title: "Start Navigation", sizing: .extendCenter) {
                    selectionAction(
                        selectedTarget.coordinates,
                        currentRoutingConfiguration()
                    )
                }

                PlainButton(icon: .icInfo, title: "Visit Documentation") {
                    UIApplication.shared.open(
                        URL(string: "https://nunav.net/lp/sdk")!
                    )
                }

                Spacer()
            }

        }.padding()
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

#Preview {
    MainView(selectionAction: {_,_ in })
}
