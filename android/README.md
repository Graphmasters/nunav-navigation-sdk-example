# NUNAV SDK Example Android

## About The Project

To serve as a hands on example, this project will demonstrate the integration and usage of the `NUNAV SDK` for Android
via a simple example app.

<img src="docs/navigation.gif" alt="Visualize the navigation" width="250"/>

## Getting Started

### Integrate Dependency
1. Add the following to your `settings.gradle` file:
   ```
   maven { url = uri("https://artifactory.graphmasters.net/artifactory/libs-release") }
   ```

2. Add the following dependency to your app's `build.gradle` file:
   ```
   implementation("net.graphmasters.multiplatform:nunav-sdk-android:{VERSION}")
   ```
   The current version is `1.0.9` (November 2024).

### Start Navigation
1. Initialize the NunavSdk with your API-Key. This only needs to happen once and must happen before using the SDK.
   ```kotlin
   NunavSdk.init(context, "Your API-key")
   ```

2. To start the navigation you must pass a destination to the SDK. This can be done by calling the `startNavigation`
   method on the `NunavSdk` instance. Use the `Destination.Builder` to create a destination.

   ```kotlin
   NunavSdk.startNavigation(
        context = context,
        destination = Destination.Builder()
            .location(52.376169, 9.741784)
            .label("Hanover Central Station")
            .build()
        )
   ```

## Permissions
For the SDK to work properly, the following permissions must be granted by the user before
calling `NunavSdk.startNavigation`:

   * INTERNET
   * ACCESS_NETWORK_STATE
   * ACCESS_FINE_LOCATION
   * ACCESS_COARSE_LOCATION
   * FOREGROUND_SERVICE
   * POST_NOTIFICATIONS

## Request an API Key
If you wish to request an API key to use the navigation SDK, please contact our [Support](https://nunav.net/lp/sdk). We will be happy to provide you with further information on obtaining an API key.

## Dependencies of NUNAV SDK
The sdk depends on the following dependencies:
1. Jetpack Compose: `"androidx.compose:compose-bom:2024.10.01"`
2. Kotlin Plugin: `"org.jetbrains.kotlin.android:2.0.0"`


