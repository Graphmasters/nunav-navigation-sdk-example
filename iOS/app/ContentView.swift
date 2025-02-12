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
    private let selectionAction: (DestinationConfiguration, RoutingConfiguration) -> Void

    @State private var selectedTransportMode: TransportMode = .car
    @State private var avoidTollRoads: Bool = false
    @State private var selectedDestination: DestinationConfiguration = .graphmastersHeadquarter

    init(selectionAction: @escaping (DestinationConfiguration, RoutingConfiguration) -> Void) {
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

                VStack(alignment: .leading, spacing: .large) {
                    Card(header: .init(title: "Navigation Example")) {
                        BodyText(
                    """
This example app demonstrates how to use the NUNAV Navigation SDK in your app to navigate to predefined targets.

Select a target and a transport mode to start the navigation. The navigation will be started with the selected transport mode and the target coordinates. Optionally, you can avoid toll roads.
"""
                        )
                    }

                    Card(header: .init(title: "Navigation Configuration")) {
                        VStack(alignment: .leading, spacing: .large) {
                            VStack(alignment: .leading,spacing: .small) {
                                HeadlineText("Selected Destination", style: .small)
                                Menu(content: {
                                    ForEach(Array(DestinationConfiguration.allCases.enumerated()), id: \.offset) { index, element in
                                        Button(action: {
                                            selectedDestination = element
                                        }) {
                                            Text(element.label ?? "")
                                        }
                                    }
                                }, label: {
                                    DropdownButton(
                                        title: selectedDestination.label ?? "",
                                        sizing: .extendCenter,
                                        action: {}
                                    )
                                })
                            }

                            VStack(alignment: .leading,spacing: .small) {
                                HeadlineText("Selected Transport Mode", style: .small)
                                Menu(
                                    content: {
                                        ForEach(Array(TransportMode.allCases.enumerated()), id: \.offset) { index, element in
                                            Button(action: {
                                                selectedTransportMode = element
                                            }) {
                                                Icon(icon(for: element))
                                                Text(title(for: element))
                                            }
                                        }
                                    },
                                    label: {
                                        DropdownButton(
                                            title: title(for: selectedTransportMode),
                                            icon: icon(
                                                for: selectedTransportMode
                                            ),
                                            sizing: .extendCenter,
                                            action: {}
                                        )
                                    }
                                )
                            }

                            VStack(alignment: .leading, spacing: .small) {
                                HeadlineText("More options", style: .small)
                                Toggle(isOn: $avoidTollRoads) {
                                    BodyText("Avoid Toll Roads")
                                }
                            }
                        }
                    }

                    FilledButton(title: "Start Navigation", sizing: .extendCenter) {
                        selectionAction(
                            selectedDestination,
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

    private func icon(for transportMode: TransportMode) -> Icons {
        switch transportMode {
        case .bicycle:
            return .icBike
        case .bus:
            return .icBus
        case .car:
            return .icCar
        case .pedestrian:
            return .icWalk
        case .truck:
            return .icTruck
        }
    }

    private func title(for transportMode: TransportMode) -> String {
        switch transportMode {
        case .bicycle:
            return "Bicycle"
        case .bus:
            return "Bus"
        case .car:
            return "Car"
        case .pedestrian:
            return "Pedestrian"
        case .truck:
            return "Truck"
        }
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


extension DestinationConfiguration: @retroactive CaseIterable {
    static let graphmastersHeadquarter = DestinationConfiguration(
        coordinate: NavigationTarget.graphmastersHeadquarter.coordinates,
        label: "Graphmasters Headquarter"
    )

    static let hanoverMainStation = DestinationConfiguration(
        coordinate: NavigationTarget.hanoverMainStation.coordinates,
        label: "Hanover Main Station"
    )

    static let invalid = DestinationConfiguration(
        coordinate: NavigationTarget.invalid.coordinates,
        label: "Invalid Destination"
    )

    public static var allCases: [DestinationConfiguration] = [.graphmastersHeadquarter, .hanoverMainStation, .invalid]
}

extension TransportMode: @retroactive CaseIterable {
    public static var allCases: [TransportMode] = [.bicycle, .bus, .car, .pedestrian, .truck]
}
